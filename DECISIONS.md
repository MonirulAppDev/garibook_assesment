# Decisions

## 1. Architecture & state management

**Clean Architecture, organised feature-first.** The features are `location`, `routing`, `navigation` and `map`. Each has `domain` (pure Dart: entities, sealed failures, repository interfaces, use cases), `data` (channel/HTTP sources, DTOs, repository implementations) and `presentation` (blocs and widgets). Code shared across features lives in `core` (config, DI, `Result`, `GeoPoint`, geo math) and `shared` (theme, widgets). Location, routing and animation are fully separated. `map` is the only feature that composes the others.

**Bloc (flutter_bloc + bloc_concurrency) with get_it/injectable.**

- **Explicit events:** long-press, app paused or resumed, a fix arriving. These are easy to reason about and to test without widgets.
- **Event transformers solve the hard concurrency cases directly:**
  - `restartable()` drops a superseded route fetch.
  - `droppable()` ignores a second permission request while one is running.
- **`close()` gives one place to release resources** (streams, timers).
- **get_it + injectable** generates the dependency graph. Only the composition root (`bootstrap`, `AppRouter`) reads from the locator; everything else uses constructor injection, so tests pass fakes in directly.
- **Cubit for the animation:** the navigation feature uses a Cubit, not a Bloc, because it is a thin adapter over a pure engine and called many times per second; an event object per frame adds nothing.

**Errors are values.** Repositories return a sealed `Result<T>` (`Ok` or `Err`). Each feature has a sealed `Failure` hierarchy, so the UI does an exhaustive `switch` and never parses strings.

## 2. Flutter ↔ native location bridge

- **Channels:**
  - `MethodChannel('navtest/location')` handles one-shot calls: `checkPermission`, `requestPermission`, `isLocationServiceEnabled`, `getCurrentLocation{timeoutMs, highAccuracy}`, `openAppSettings`, `openLocationSettings`.
  - `EventChannel('navtest/location/updates')` carries the live stream; listen arguments are `{intervalMs, minDistanceM, highAccuracy}`.
  - An EventChannel fits a stream because its `onListen`/`onCancel` hooks line up exactly with native start and stop.
- **One contract, two mirrored files:** `location_channel_contract.dart` and `LocationChannelContract.kt` define the method names, argument keys, permission values and error codes. An iOS plugin implementing the same strings needs **no Dart changes**. If no native handler exists (iOS today), the `MissingPluginException` maps to `LocationNotSupported` instead of crashing.
- **Error mapping:**
  - Native code returns `PlatformException(code)` using a fixed set of codes: `PERMISSION_DENIED`, `PERMISSION_DENIED_FOREVER`, `SERVICES_DISABLED`, `TIMEOUT`, `PERMISSION_REQUEST_IN_PROGRESS`, `NO_ACTIVITY`, `PLAY_SERVICES_UNAVAILABLE`, `UNKNOWN`.
  - The data source turns these into `LocationException(code)`, and the repository maps them to sealed `LocationFailure` types.
  - Stream errors are delivered as `Err` values rather than stream errors, so one bad event does not end the subscription.
- **Permanently denied:** Android has no direct API for this. We report it when the permission is not granted, *we have asked before* (a SharedPreferences flag), and `shouldShowRequestPermissionRationale` is false. The "asked before" flag stops a fresh install from being misreported.
- **Stream lifecycle:**
  - Native `requestLocationUpdates` runs only between `onListen` and `onCancel`.
  - `onCancel`, `onDetachedFromActivity` and `onDetachedFromEngine` all call `removeLocationUpdates`.
  - On the Dart side, `LocationBloc` cancels its subscription when the app goes to the background and in `close()`, and resubscribes on resume. Nothing runs in the background.
- **One-shot timeout:** `getCurrentLocation` has its own `Handler` timeout as well as Play Services' duration limit, and a `replied` guard ensures a single reply. If the result is null, it falls back to a last-known fix that is at most 2 minutes old.
- **Permission UX:** the app checks silently on launch. The OS dialog only appears after the user taps **Enable location** on an explanation card. Each state has its own card: denied, permanently denied ("Open settings", launched natively), services off, timeout, and unsupported. Returning from Settings re-checks automatically.

**No-location policy:** routing is **not** blocked. If there is no fix (denied, services off, timeout, unsupported), the first long-press sets a **manual start point** and the next sets the destination. When a fix later arrives, a "Route from my location" chip appears. The app never gets stuck, and reviewers can test routing on an emulator without GPS.

## 3. Routing safety

- **Rate limiting:** a long-press sets the destination pin immediately. The fetch is debounced by 400 ms, and a `RateLimiter` keeps at least 1 s between OSRM calls.
- **Stale responses** are guarded in three layers:
  1. `restartable()` cancels the previous handler.
  2. A monotonically increasing request id drops any response that isn't the latest.
  3. The data source cancels the previous Dio `CancelToken`, and that result maps to an ignored `RoutingCancelled`.
- **Slow responses:** after 3 s the panel says the server is slow, and the Dio timeouts come from the flavor config.
- **Typed failures:** `NoRoute` (including OSRM's HTTP 400 `NoRoute`/`NoSegment`), network, timeout, 429, 5xx and malformed body each map to their own failure type.

## 4. Interpolation & bearing

- **`RouteGeometry`** cleans the polyline: it drops invalid coordinates and any point within 0.5 m of the previous one. It then precomputes cumulative haversine distances and per-segment bearings. Because every remaining segment has a positive length, interpolation never divides by zero.
- **Constant speed:** the animator advances *distance*, `travelled += baseSpeed × multiplier × dt`. `positionAt(d)` binary-searches the segment and interpolates linearly inside it. Speed therefore does not depend on how dense the points are; a test compares a 1-segment and a 500-segment line.
- **`dt` cap:** each tick is limited to 100 ms, so a frame hitch or a resume from background cannot teleport the car. The cubit also auto-pauses in the background and resumes only if it was the one that paused.
- **Bearing:** the target heading is the current segment's bearing. `BearingSmoother` turns toward it by `shortestDelta = ((to − from) mod 360)`, wrapped into (−180, 180], at a bounded, frame-rate-independent rate. 359° → 1° turns +2°.
- **NaN safety:** every NaN-prone operation is guarded (`asin` clamp, `atan2(0,0)` → 0, non-finite inputs → 0), and tests sample frames along messy routes.
- **Timing source:** frames come from a vsync `Ticker` owned by `NavigationTicker`. It runs only while playing and is disposed with the screen, so the pure engine is testable with plain `tick()` calls.
- **Remaining time** = remaining metres ÷ OSRM's average speed, a realistic ETA independent of the demo speed.

## 5. Flavor configuration

- **Android:** `productFlavors { dev, prod }` set the `applicationIdSuffix` (`.dev`) and an `appName` manifest placeholder.
- **Dart:**
  - `FlavorConfigLoader` reads `appFlavor` (set by `--flavor`) and loads `assets/config/<flavor>.json` into a freezed `FlavorConfig`: app name, package name for the OSM user agent, OSRM base URL, tile URL, timeouts, DEV badge, network logs.
  - It is registered `@preResolve` in DI, so Dio's `baseUrl` comes from config.
  - Debug builds without `--flavor` fall back to `dev`; release builds fail fast.
- **DEV indicator:** the dev build wraps the app in a "DEV" `Banner`.

## 6. Before shipping to production

- **Battery:**
  - use balanced priority with adaptive intervals (slower when stationary, faster while navigating), and batch updates
  - run the live stream only when it's needed (it currently powers the blue dot)
- **Background location:** a real navigation product needs a foreground service with a persistent notification, `ACCESS_BACKGROUND_LOCATION` with Play policy justification, and handling for Doze and OEM battery killers.
- **Routing server:** the public OSRM demo server is not for production. Self-host OSRM or Valhalla on regional extracts, or use a commercial router with an SLA. Put an API gateway in front for auth, rate limits and caching.
- **Tiles:** OSM's tile servers forbid heavy use. Use a paid tile CDN or self-hosted vector tiles, with an offline tile cache.
- **Cost at scale:**
  - a route request per destination is cheap when self-hosted, while a commercial API is billed per request
  - client-side debounce, plus caching recent origin→destination pairs, cuts the request count
- **Reliability and quality:** crash reporting and analytics, retry with back-off for transient routing errors, accessibility labels, localisation, a proper release signing config, R8 rules, and CI running `analyze`, tests and both flavor builds.

## 7. Deliberately left out (time)

- **Bonus features:** iOS (Swift/CoreLocation and schemes) and camera tilt (`flutter_map` is 2D). Live GPS, snap-to-route, off-route re-routing and the rotating camera are implemented (section 8).
- **Tests:** widget and golden tests for the panels. Logic is covered by 89 unit and bloc tests.
- **`bloc_test`:** it can't be installed alongside `freezed 4.x` (they need different `analyzer` versions), so blocs are tested with plain stream and state assertions.

## 8. Bonus: live GPS, snap-to-route, off-route, navigation camera

- **One engine interface:** `RouteAnimator` (simulation) and `LiveRouteTracker` (GPS) both implement `NavigationEngine`. The cubit only swaps which engine is active (`DriveMode`), and the controls, ticker and UI stay unchanged.
- **Live GPS:** fixes from the native stream flow LocationBloc → MapPage → `NavigationCubit.onLivePosition`, as a navigation-owned `LivePosition` type, so the navigation feature never imports the location feature. Fixes arrive every 1–2 s. Between fixes the car **glides** over 1 s; when both fixes are on the route, it glides *by distance along the road*, so it follows curves instead of cutting corners.
- **Snap to route:** `RouteGeometry.project()` projects the fix onto every segment in a local equirectangular plane and picks the nearest. A fix within 50 m is drawn at the projected point, with the road's bearing. Farther fixes are drawn raw, using the device course (when moving) or the movement direction.
- **Off-route:**
  - **Trigger:** more than 50 m from the line on **2 consecutive** fixes. Fixes with accuracy worse than 40 m are ignored, so GPS jitter can't trigger it. After triggering, the detector needs 2 fresh confirmations.
  - **Cooldown:** the cubit applies a 15 s cooldown, then emits a re-route request.
  - **Re-route:** MapPage turns the request into `RouteRerouteRequested(from)`. That goes through the same debounce, rate-limit and stale guards as every other route request. The new route keeps the live session running and does not refit the camera.
- **Navigation camera:**
  - While following, `moveAndRotate(car, zoom, -bearing)` keeps the car centred with its heading up, using the smoothed bearing so the map doesn't jitter.
  - The camera returns to north-up when navigation stops or a new route is fitted. User rotation gestures stay disabled.
  - There is no tilt, because `flutter_map` is 2D.
