# Implementation Plan: Route & Car Navigation

Source brief: `documents/Senior Mobile Developer Assessment_ Route & Car Navigation - Google Docs.pdf`
Target: Flutter 3.47.5 (stable). Android is required; iOS is a bonus.
Timebox: about 3 days of work (5 calendar days at most).

---

## 1. Goals and hard constraints (from the brief)

| # | Constraint | How we satisfy it |
|---|---|---|
| C1 | Use only free services that need no API key | OSM tiles, public OSRM, no Google/Mapbox |
| C2 | **No** geolocator / location / permission_handler | Own Kotlin plugin using `FusedLocationProviderClient`, exposed through MethodChannel and EventChannel |
| C3 | OSM tile policy | `userAgentPackageName` set from the flavor's app ID, plus a visible `RichAttributionWidget` showing "© OpenStreetMap contributors" |
| C4 | OSRM allows about 1 request/s | Debounce long-press (400 ms) **and** a global throttle of at least 1 s between requests, with a single in-flight request |
| C5 | Stale responses must not overwrite newer ones | A monotonically increasing request token; responses whose token is not current are dropped (and the old HTTP request is cancelled) |
| C6 | Route animation must be testable without the map | Pure-Dart `RouteGeometry` + `RouteAnimator` with an injectable clock |
| C7 | dev and prod flavors on Android | `productFlavors` with an app-name `resValue`, `applicationIdSuffix ".dev"`, per-flavor config asset, and a DEV badge |
| C8 | No NaN/Infinity on messy routes | Deduplicate points, skip zero-length segments, guard every division, use `isFinite` asserts in tests |
| C9 | Background/foreground must not crash or leak | `WidgetsBindingObserver` auto-pauses the animation and location stream; every resource is disposed in `ref.onDispose` / `dispose()` |

---

## 2. Tech choices

> **Updated:** the stack is now flutter_bloc + get_it/injectable + go_router + dio/retrofit + freezed. See **[ARCHITECTURE.md](ARCHITECTURE.md)** for the full stack, folder layout, layer rules, and how SOLID is applied.

Android native: `com.google.android.gms:play-services-location:21.3.0`.

---

## 3. Architecture

See **[ARCHITECTURE.md](ARCHITECTURE.md)**. The rest of this plan still applies, with these name changes:
- "Riverpod Notifier / controller" becomes a **Bloc** in `features/<x>/presentation/bloc/`.
- "PlatformLocationService" becomes **`MethodChannelLocationDataSource`** (data) behind `LocationRepository` (domain) and the location use cases.
- "OsrmRoutingRepository (http)" becomes **`OsrmApi` (retrofit) → `OsrmRemoteDataSource` → `RoutingRepositoryImpl`**.
- `ref.onDispose` becomes `Bloc.close()` / `State.dispose()`.
- Flavor JSON lives in `assets/config/<flavor>.json`.

---

## 4. Native location bridge (Android, Kotlin)

### 4.1 Channel contract (platform-agnostic, so iOS can implement the same contract later)

`MethodChannel("<appId-agnostic>/location")`, using the fixed name `navtest/location`:

| Method | Args | Returns |
|---|---|---|
| `checkPermission` | – | `"granted" \| "grantedApproximate" \| "denied" \| "deniedForever"` |
| `requestPermission` | – | same as above |
| `isLocationServiceEnabled` | – | `bool` |
| `getCurrentLocation` | `{timeoutMs:int, highAccuracy:bool}` | `Map` fix |
| `openAppSettings` | – | `bool` |
| `openLocationSettings` | – | `bool` |

`EventChannel("navtest/location/updates")`. `listen` arguments: `{intervalMs, minDistanceM, highAccuracy}`. It emits `Map` fixes, or an error event.

Fix map: `{lat, lng, accuracy, bearing?, speed?, timestampMs, isMock}`.

**Error codes** (`PlatformException.code` / `EventSink.error` code), defined as constants on both sides:
`PERMISSION_DENIED`, `PERMISSION_DENIED_FOREVER`, `SERVICES_DISABLED`, `TIMEOUT`,
`PERMISSION_REQUEST_IN_PROGRESS`, `NO_ACTIVITY`, `PLAY_SERVICES_UNAVAILABLE`, `UNKNOWN`.

Dart mapping (`PlatformLocationService`):
- A known code maps to the matching subclass of the sealed `LocationException`.
- `MissingPluginException`, or a platform that is neither Android nor (later) iOS, maps to `LocationNotSupportedException`. The app shows "Location is not supported on this platform yet" and never crashes.
- An unknown code maps to `LocationUnknownException(code, message)`, kept for logs only. The UI never parses strings.

### 4.2 Kotlin classes (`android/app/src/main/kotlin/<pkg>/location/`)
- `LocationPlugin` implements `FlutterPlugin`, `ActivityAware`, `MethodCallHandler`, and `PluginRegistry.RequestPermissionsResultListener`. It is registered in `MainActivity.configureFlutterEngine`.
- `PermissionManager`
  - Request `ACCESS_FINE_LOCATION` + `ACCESS_COARSE_LOCATION`. Coarse-only (the Android 12+ "approximate" option) maps to `grantedApproximate`.
  - **Permanently-denied detection:** the result is denied **and** `!shouldShowRequestPermissionRationale` **and** we have asked before. The "asked before" flag is stored in `SharedPreferences`, so a first-launch "never asked" state is not reported as forever-denied.
  - Only one pending request is allowed at a time. A second request gets `PERMISSION_REQUEST_IN_PROGRESS`.
- `LocationProvider` (wraps `FusedLocationProviderClient`)
  - One-shot: `getCurrentLocation(Priority, CancellationTokenSource)` plus a `Handler.postDelayed` timeout that cancels the token and replies `TIMEOUT`. It replies only once, guarded by a `replied` flag. If the fix is null, it falls back to `lastLocation` when that is fresher than 2 minutes; otherwise it replies `TIMEOUT`.
  - Stream: `LocationStreamHandler : EventChannel.StreamHandler`. `onListen` checks permission and services, then calls `requestLocationUpdates(LocationRequest, callback, Looper.getMainLooper())`. **`onCancel` calls `removeLocationUpdates`.** Updates are also removed in `onDetachedFromActivity` and `onDetachedFromEngine`, so nothing runs after the screen or engine is gone.
  - Services check: `LocationManagerCompat.isLocationEnabled`.
- `SettingsLauncher`: `ACTION_APPLICATION_DETAILS_SETTINGS` (`package:` URI) and `ACTION_LOCATION_SOURCE_SETTINGS`.
- Manifest: `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`, `INTERNET`. **No** background location permission and **no** foreground service.

### 4.3 Dart-side behaviour (`LocationController`)
States: `idle → explaining → requesting → acquiring → ready(fix) | error(LocationException)`.
- On launch: call `checkPermission` only, which never prompts. If already granted, go straight to acquiring.
- If not granted: the map opens on a neutral default view with a card: *"Show your position to plan a route from where you are"* and an **Enable location** button. The system prompt appears **only when the user taps it**. This is the "appropriate moment".
- Acquiring: a loading chip saying "Finding your location…". `getCurrentLocation(timeout: 15s)`. On timeout, show "Couldn't get a GPS fix" with **Retry** and **Pick start on map**.
- `deniedForever`: a card with an **Open settings** button, which calls native `openAppSettings`. On `AppLifecycleState.resumed`, re-check the permission automatically.
- `SERVICES_DISABLED`: a card with **Turn on location**, which calls `openLocationSettings`, and the same re-check on resume.
- Live stream: subscribe only while it's needed (blue-dot updates, or the live GPS bonus). Cancel on `paused` and re-subscribe on `resumed`. The `StreamSubscription` is cancelled in `ref.onDispose`.

---

## 5. Routing

- `OsrmRoutingRepository.fetchRoute(from, to, {cancelToken})` sends `GET {baseUrl}/route/v1/driving/{fromLng},{fromLat};{toLng},{toLat}?overview=full&geometries=polyline&alternatives=false&steps=false`. Note the **lng,lat** order. A unit test covers this.
- Timeouts: hard timeout 12 s, which raises `RoutingTimeoutException`. A soft "still working…" hint appears after 3 s so slow responses are visible.
- Error mapping:
  - `code == "NoRoute"`, `"NoSegment"`, or empty `routes` → `NoRouteException`
  - `SocketException` / `ClientException` → `NetworkException`
  - `429` → `RateLimitedException`
  - `5xx` → `ServerException`
  - malformed JSON → `BadResponseException`
- **RouteController**
  - A long-press sets the destination marker **immediately** (instant feedback). The fetch is debounced by 400 ms, and a `Throttler` keeps at least 1 s between actual requests.
  - Each request gets `++_requestId`. On completion, `if (id != _requestId || !ref.mounted) return;` drops the result. The previous `http.Client` request is aborted by closing its per-request client. This is the stale-response guard.
  - On success: decode the polyline, set the route, signal the UI to fit the camera (`CameraFit.coordinates` with padding), and show distance (km/m) and duration (min/h) in the info card.
  - Errors: show a snackbar/banner with a typed message and a **Retry** button. The previous valid route is kept until a new one succeeds.
- **No-location decision (to be written up in DECISIONS.md):** we use a **manual start-point fallback**. When no fix is available (permission denied, timeout, or services off), a banner offers *"Long-press to set a start point"*. The first long-press sets the start, the next one sets the destination. If location later becomes available, a chip offers *"Use my location"*. The app never blocks or gets stuck, and the reviewer can still exercise routing on an emulator without GPS.

---

## 6. Car navigation engine (pure Dart, the core of the testing story)

### 6.1 `RouteGeometry`
- Input: the raw `List<LatLng>`.
- Cleaning: drop non-finite coordinates, and drop consecutive points closer than 0.5 m (handles duplicates and near-duplicates). If fewer than 2 points remain, it becomes a "degenerate route": the car sits at the destination and the route counts as finished immediately.
- Precompute `cumulative[i]` (metres, haversine), `totalLength`, and the per-segment bearing.
- `positionAt(double d)`:
  - Clamp `d` to `[0, total]`.
  - Binary-search the segment.
  - `t = (d - cum[i]) / segLen`. `segLen > 0` is guaranteed after cleaning, but we still guard with `segLen <= ε ? 0 : …`.
  - Linear interpolation of lat/lng is fine at segment scale.
  - Returns `(LatLng, bearingDeg)`.
- **Constant speed:** progress is measured in **metres**, not point indices, so dense or sparse point spacing has no effect on speed.

### 6.2 `RouteAnimator`
- State: `idle | playing | paused | finished`, plus `distanceTravelled`, `speedMultiplier ∈ {1,2,5}`.
- `tick(Duration dt)`: if playing, `distance += baseSpeed * multiplier * dtSeconds`, where `dt` is **clamped to at most 100 ms**. That way a resume after the app was in the background, or a frame hitch, cannot teleport the car. When `distance >= total`, the state becomes `finished`.
- `start()`, `pause()`, `resume()`, `reset()`, `setMultiplier()`. Invalid transitions do nothing (no-ops).
- `baseSpeed`: a demo speed (e.g. 30 m/s ≈ 108 km/h) so a typical route animates in tens of seconds. It's configurable.
- Remaining distance = `total - distance`. **Remaining time = remaining distance / (OSRM distance / OSRM duration)**. That keeps the ETA in realistic driving time, independent of the demo speed, and is documented in DECISIONS.md.
- It emits an immutable `NavigationFrame {position, bearing, remainingM, remainingS, progress, status}`.

### 6.3 Bearing
- `shortestDelta(from, to) = ((to - from + 540) % 360) - 180`.
- `BearingSmoother` eases the displayed heading toward the target heading, at most about 360°/s and frame-rate independent, by adding the shortest delta. Going 359° to 1° turns +2° and never −358°.
- The bearing is taken from the segment ahead of the current position. If that segment is degenerate, the last valid bearing is kept, so the heading never becomes NaN.

### 6.4 Flutter bridge (`NavigationController`)
- A `Ticker` (created from a `TickerProvider` handed over by the screen) calls `animator.tick(elapsed - lastElapsed)`. The ticker is the only Flutter-dependent part.
- The car marker updates every frame through a small `ValueNotifier<NavigationFrame>` / provider that only the marker layer listens to. The whole map is not rebuilt each frame.
- **Camera follow:** while `following == true`, `mapController.move(frame.position, zoom)` is throttled to about 30 fps. A `MapEventMove` / `MapEventFlingAnimation` whose source is **not** `MapEventSource.mapController` sets `following = false` and shows the **Recenter** FAB. Recenter sets `following = true` and snaps back.
- **Lifecycle:** on `paused`/`hidden`, the animator is auto-paused and `wasPlayingBeforeBackground` is remembered. On `resumed`, it resumes only if it was playing. Ticker, observer, and subscriptions are disposed in `dispose()`/`ref.onDispose`. Every async callback checks `mounted`/`ref.mounted`.

### 6.5 UI controls
A bottom panel with **Start**, **Pause/Resume**, and **Reset**, a 1x/2x/5x `SegmentedButton`, and live **remaining distance / remaining time** with a progress bar. Buttons are enabled based on the animator state.

---

## 7. Build flavors

### Android (`android/app/build.gradle.kts`)
```kotlin
defaultConfig { applicationId = "com.garibook.navtest" }
flavorDimensions += "env"
productFlavors {
    create("dev")  { dimension = "env"; applicationIdSuffix = ".dev"; versionNameSuffix = "-dev"
                     resValue("string", "app_name", "NavTest Dev") }
    create("prod") { dimension = "env"; resValue("string", "app_name", "NavTest") }
}
```
- Manifest: `android:label="@string/app_name"`.
- Optional: a different launcher-icon tint for dev in `src/dev/res`.

### Dart config
- `assets/config/dev.json` and `assets/config/prod.json`:
  `{ "flavor": "dev", "osrmBaseUrl": "https://router.project-osrm.org", "tileUrl": "https://tile.openstreetmap.org/{z}/{x}/{y}.png", "showDevBadge": true }`
- `flavor_loader.dart` reads `appFlavor` (from `package:flutter/services.dart`, set automatically by `--flavor`), loads the matching JSON, and fails loudly in debug if it's missing. **Changing the server only requires editing the JSON.**
- `userAgentPackageName` comes from the runtime package name, so it's correct for dev and prod.
- DEV indicator: a `Banner(message: 'DEV')` in the corner plus a "DEV" chip in the app bar when `showDevBadge`.

Commands:
```
flutter run --flavor dev
flutter run --flavor prod
flutter build apk --flavor prod --release
```

---

## 8. Robustness checklist
- [ ] Route with repeated identical points → no NaN, smooth motion (unit test)
- [ ] Route with 2 identical points only → degenerate handling, no crash (unit test)
- [ ] Very short route (< 1 m) → finishes immediately (unit test)
- [ ] Huge dt (backgrounded 5 min) → car moves at most 100 ms worth (unit test)
- [ ] Rapid 10 long-presses → at most 1 request/s, final result = last press (unit test with fake clock + MockClient)
- [ ] Slow response A then fast B → A ignored (unit test)
- [ ] Rotate app / background mid-animation → no exceptions, no ticking while paused (manual)
- [ ] Leave the screen while the stream is active → native `removeLocationUpdates` called (log + manual)
- [ ] Airplane mode → NetworkException banner, app usable (manual)

---

## 9. Testing plan

| Layer | Tests |
|---|---|
| `geo_math` | haversine against known distances; bearing N/E/S/W; `shortestDelta(359,1)=2`, `(1,359)=-2`, `(0,180)` |
| `polyline_decoder` | Google reference string `_p~iF~ps|U_ulLnnqC_mqNvxq`@` → 3 known points; empty string |
| `RouteGeometry` | duplicate/near-duplicate removal; `positionAt` at 0, mid, end, beyond end; all outputs `isFinite` |
| `RouteAnimator` | constant speed on dense vs sparse routes (same elapsed → same distance); multiplier; pause stops progress; reset; finish; dt clamp |
| `OsrmRoutingRepository` | URL lng,lat order; each error mapping; parse distance/duration |
| `RouteController` | debounce/throttle with `fake_async`; stale-response guard; keeps previous route on error |
| `PlatformLocationService` | `TestDefaultBinaryMessengerBinding` mock channel: each error code → correct typed exception; `MissingPluginException` → NotSupported; stream cancel invokes `cancel` |
| Widget | DEV badge shown only for dev config; permission card buttons call the service (fake service override) |

Run with `flutter test` and `flutter analyze` (zero warnings).

---

## 10. Work breakdown and commit plan

Each line below is one (or a few) commits, so the history stays clean and logical.

**Day 1: foundation and native location**
1. `chore: initial Flutter scaffold` (`git init`, the current state)
2. `chore: set application id, lints, add dependencies`
3. `build(android): add dev/prod productFlavors with per-flavor app name`
4. `feat(config): flavor config loaded from per-flavor JSON asset + DEV badge`
5. `feat(location): define Dart LocationService interface, models, typed exceptions`
6. `feat(android): native location plugin – permission flow + settings launchers`
7. `feat(android): one-shot getCurrentLocation with timeout`
8. `feat(android): location update stream with clean cancellation`
9. `feat(location): PlatformLocationService channel implementation + error mapping`
10. `test(location): channel error mapping and not-supported behaviour`

**Day 2: map, routing, and permission UX**
11. `feat(map): map screen with OSM tiles, attribution, user marker`
12. `feat(location): LocationController + permission/explanation/settings UI states`
13. `feat(routing): polyline decoder + tests`
14. `feat(routing): OSRM repository with typed errors + tests`
15. `feat(routing): RouteController with debounce, throttle, stale-response guard + tests`
16. `feat(map): long-press destination, route polyline, fit camera, distance/ETA card`
17. `feat(routing): manual start-point fallback when location unavailable`

**Day 3: animation, polish, and docs**
18. `feat(navigation): geo math + RouteGeometry with cleaning + tests`
19. `feat(navigation): RouteAnimator state machine + tests`
20. `feat(navigation): bearing smoother with shortest-path rotation + tests`
21. `feat(navigation): ticker bridge, car marker, controls, speed multiplier`
22. `feat(navigation): camera follow, user-pan detection, recenter button`
23. `fix(navigation): lifecycle auto-pause and resource cleanup audit`
24. `docs: README (build/run per flavor, versions, limitations)`
25. `docs: DECISIONS.md`

**Day 4+ (bonus, only after everything above is solid)**, in order of value per effort:
1. Live GPS mode (car follows the native stream) + snap-to-route (nearest-point projection onto segments)
2. Off-route detection (more than 50 m from the polyline for 2 consecutive fixes leads to a throttled re-route)
3. Navigation camera: map rotates with the heading (`mapController.rotate`). flutter_map has no tilt; document that.
4. iOS: Swift `CLLocationManager` plugin implementing the same contract; reduced-accuracy handling (`accuracyAuthorization`, `.grantedApproximate`); Xcode schemes/configurations for dev and prod. This needs a Mac.

---

## 11. Deliverables checklist
- [ ] Public GitHub repo with the history above
- [ ] `README.md`: prerequisites, `flutter run --flavor dev|prod`, Flutter and package versions (`flutter --version`, pubspec.lock), known limitations, assumptions made
- [ ] `DECISIONS.md` (1–2 pages): architecture and Riverpod rationale; bridge design (channel choice, error codes, stream lifecycle); interpolation and bearing math; flavor setup; production changes (battery: balanced priority and adaptive intervals, background location + foreground service, a self-hosted OSRM/Valhalla or paid routing SLA, tile CDN or own tile server and cost at scale, caching, analytics/crash reporting); what was left out
- [ ] Screen recording (1–2 min, real Android device): permission flow (including deny → settings), long-press route, animation with pause/speed/recenter, both flavors installed side by side
- [ ] `flutter analyze` clean, `flutter test` green

## 12. Assumptions (to copy into README)
- The demo car speed is intentionally faster than real driving. The remaining time uses OSRM's average speed, so it reflects real ETA.
- The location stream runs only while the app is in the foreground. Background tracking is out of scope.
- If no location fix is available, the user sets a manual start point (see §5).
- The app ID `com.garibook.navtest` is a placeholder and can be changed in one place in Gradle.
