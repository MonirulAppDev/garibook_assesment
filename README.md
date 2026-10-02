# NavTest: Route & Car Navigation (Flutter)

A single-screen Flutter app with these features:
- It gets the device location through a **native Kotlin** implementation (FusedLocationProviderClient over MethodChannel/EventChannel, with no location or permission plugins).
- It fetches a driving route from the **public OSRM** server to a destination you pick by **long-pressing** the map.
- It animates a **car** along that route at a constant speed, like a ride-hailing tracking screen.

It uses only free services with no API key: OpenStreetMap tiles via `flutter_map`, and OSRM for routing.

Design rationale is in **[DECISIONS.md](DECISIONS.md)**. The layer and folder guide is in **[documents/ARCHITECTURE.md](documents/ARCHITECTURE.md)**.

---

## Requirements

| Tool | Version used |
|---|---|
| Flutter | **3.47.5** (stable) |
| Dart | 3.13.4 |
| Android Gradle Plugin / Gradle | 9.1.0 / 9.3.1 |
| JDK | 17 |
| Android device | API 24+ with Google Play services |

iOS is **not implemented**. On iOS, the Dart layer reports a typed "not supported" location error, and the app still works with a manual start point (see Known limitations).

## Build & run

Generated code (`*.g.dart`, `*.freezed.dart`, `injection.config.dart`) is committed. If you change any annotated class, regenerate with:

```bash
dart run build_runner build
```

### Flavors (Android)

| Flavor | Application ID | App name | Extras |
|---|---|---|---|
| `dev` | `com.garibook.navtest.dev` | NavTest Dev | "DEV" corner banner, network logging |
| `prod` | `com.garibook.navtest` | NavTest | none |

The two flavors have different application IDs, so both can be installed on the same device side by side.

```bash
flutter pub get

# run
flutter run --flavor dev
flutter run --flavor prod

# build
flutter build apk --flavor dev  --debug
flutter build apk --flavor prod --release   # signed with the debug key (demo only)
```

The routing server, tile URL and timeouts come from the flavor's config file:
`assets/config/dev.json` and `assets/config/prod.json`.
To point a flavor at another OSRM server, change `osrmBaseUrl` in its config file. No code changes are needed.

### Tests

```bash
flutter analyze
flutter test        # 89 tests: engine, live tracker, blocs, channel mapping, OSRM data source
```

## How to use

1. When the app opens it **checks** the location permission but never prompts on launch. A card explains why location is useful, with an **Enable location** button.
2. Grant permission. The app shows "Finding your location…" until the first fix arrives.
3. **Long-press** anywhere to set a destination. The route is drawn, the camera fits it, and the panel shows the ETA and distance.
4. Press **Start**. The car drives the route and the camera follows it.
   - Panning the map stops following and shows a **Recenter** button.
   - Use **Pause/Resume**, **Reset** and **1x / 2x / 5x** to control playback.
   - Remaining time and distance update live.
   - While following, the map rotates so the car always points up.
5. **Live GPS** (needs a location fix): switch the panel from **Simulate** to **Live GPS** and press Start. The car follows your real position, snapped to the road when within 50 m. If you stay more than 50 m off the route, a new route is fetched automatically (at most once every 15 s).
6. **Without location** (denied, services off, no fix, unsupported platform), the first long-press sets a **start point** and the second sets the destination. Once GPS becomes available, a **Route from my location** chip appears.

## Packages

| Purpose | Package | Version |
|---|---|---|
| State management | flutter_bloc / bloc / bloc_concurrency | 9.1.1 / 9.2.1 / 0.3.0 |
| Dependency injection | get_it / injectable | 9.3.0 / 3.0.0 |
| Navigation | go_router | 18.0.2 |
| Networking | dio / retrofit / pretty_dio_logger | 5.11.1 / 4.10.0 / 1.4.0 |
| Models | freezed_annotation / json_annotation | 3.1.0 / 4.12.0 |
| Map | flutter_map / latlong2 | 8.3.2 / 0.10.1 |
| Logging | logger | 2.8.0 |
| Codegen (dev) | build_runner / freezed / json_serializable / retrofit_generator / injectable_generator | 2.16.1 / 4.0.2 / 6.14.1 / 10.2.11 / 3.1.3 |
| Tests (dev) | flutter_test / http_mock_adapter | SDK / 0.6.1 |
| Android native | com.google.android.gms:play-services-location / androidx.core:core-ktx | 21.3.0 / 1.13.1 |

## Project layout (short)

```
lib/
  app/        bootstrap, MaterialApp.router, GoRouter (composition root)
  core/       flavor config, DI, Result/Failure, Dio, geo math, utils
  shared/     theme (M3 light/dark + NavColors), reusable widgets, formatters
  features/
    location/    domain · data (channel contract + MethodChannel source) · presentation (bloc, status panel)
    routing/     domain · data (Retrofit OSRM API, polyline decoder) · presentation (bloc, panel)
    navigation/  domain (RouteGeometry, RouteAnimator, BearingSmoother) · presentation (cubit, ticker, car, panel)
    map/         the single MapPage composing the features
android/app/src/main/kotlin/com/garibook/navtest/location/   native location layer
```

## Assumptions

- **Demo speed:** the simulated car is faster than real driving. At 1x it covers a route in about 60 s, clamped to between 15 and 250 m/s, and its speed is constant along the route. **Remaining time** uses OSRM's own average speed (`distance / duration`), so it shows a realistic driving ETA.
- **Re-routing:** in **Simulate** mode the route is planned once, from the location at the moment you long-press. In **Live GPS** mode it re-routes automatically when you leave the route.
- **Foreground only:** location is only used while the app is in the foreground. The stream stops when the app goes to the background or the screen closes.
- **Placeholder IDs:** `com.garibook.navtest` and the names "NavTest" / "NavTest Dev" are placeholders.
- **Approximate permission:** granting only *approximate* location (Android 12+) is treated as usable, and reported to Dart as `grantedApproximate`.
- **Following and zoom:** a pinch-zoom or double-tap counts as the user moving the map, so it also stops camera following.

## Known limitations

- **iOS location is not implemented.** The Dart contract is ready for it: a Swift plugin registering the same channel names and codes would work without Dart changes. On iOS today, location reports `LocationNotSupported` and you set the start point manually.
- **Play services:** a Google Play services device is required for native location. Without it, Dart gets a typed `PLAY_SERVICES_UNAVAILABLE` error.
- **Public servers:** the public OSRM demo server is rate-limited and has no uptime guarantee. The app debounces long-presses, keeps at least 1 s between requests, and reports 429 and timeouts clearly, but it cannot fix an outage.
- **No tilt:** the navigation camera rotates with the car but does not tilt, because `flutter_map` is a 2D map with no tilt support.
- **Not implemented (bonus):** iOS (Swift location layer and iOS flavors).
- **Snap search:** snap-to-route checks every route segment for each fix, with no "progress window". On routes that loop back close to themselves, a fix could snap to the wrong pass.
- **Release signing:** release builds are signed with the debug key.
