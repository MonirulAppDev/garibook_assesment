# Architecture

The app uses Clean Architecture, organised **feature-first**, with a `core` layer for infrastructure and a `shared` layer for UI building blocks.

## Stack

| Concern | Package |
|---|---|
| State management | `flutter_bloc` |
| Dependency injection | `get_it` + `injectable` (code-generated) |
| Navigation | `go_router` |
| Networking | `dio` + `retrofit`, `pretty_dio_logger` (dev only) |
| Models / immutability | `freezed` + `json_serializable` |
| Map | `flutter_map` + `latlong2` (OSM tiles) |
| Logging | `logger` behind the `AppLogger` interface |
| Tests | `flutter_test`, `http_mock_adapter`, hand-written fakes (no mocking library) |

> `bloc_test` was left out: every version of it needs an `analyzer` older than the one `freezed 4.x` requires. Blocs are tested with plain `flutter_test` stream matchers (`emitsInOrder`).

## Folder layout

```
lib/
├─ main.dart                  # → bootstrap()
├─ app/                       # composition root
│  ├─ bootstrap.dart          # bindings, DI init, global error handlers
│  ├─ app.dart                # MaterialApp.router + theme + FlavorBanner
│  └─ router/                 # GoRouter (AppRouter), AppRoutes constants
├─ core/                      # framework-level, feature-agnostic
│  ├─ config/                 # Flavor, FlavorConfig (freezed/json), loader
│  ├─ di/                     # get_it instance, @InjectableInit, AppModule
│  ├─ error/                  # Failure base type
│  ├─ result/                 # sealed Result<T> (Ok / Err)
│  ├─ usecase/                # UseCase / StreamUseCase contracts
│  ├─ network/                # Dio module, interceptors
│  ├─ geo/                    # GeoPoint (pure-Dart coordinate)
│  ├─ logging/                # AppLogger interface + impl
│  └─ utils/                  # RateLimiter
├─ shared/                    # reusable UI, no business logic
│  ├─ theme/                  # AppTheme (M3 light/dark), AppColors, NavColors (ThemeExtension), spacing
│  ├─ widgets/                # FlavorBanner, StatusCard, ...
│  └─ extensions/             # BuildContext helpers, GeoPoint ↔ LatLng
└─ features/
   ├─ location/               # native location via platform channels
   │  ├─ domain/  entities · failures (sealed) · repositories (abstract) · usecases
   │  ├─ data/    datasources (channel contract + MethodChannel impl) · models · repositories (impl)
   │  └─ presentation/  LocationBloc · status panel
   ├─ routing/                # OSRM route fetching
   │  ├─ domain/  NavRoute · RoutingFailure (sealed) · RoutingRepository · GetDrivingRoute
   │  ├─ data/    OsrmApi (retrofit) · OsrmRemoteDataSource · PolylineDecoder · DTOs · repo impl
   │  └─ presentation/  RoutingBloc · route panel
   ├─ navigation/             # car animation engine (pure Dart)
   │  ├─ domain/  NavigationEngine · RouteGeometry (+ project) · RouteAnimator · LiveRouteTracker · BearingSmoother
   │  └─ presentation/  NavigationCubit (DriveMode) · NavigationTicker · car marker · panel
   └─ map/                    # the single screen that composes the features
      └─ presentation/  pages/map_page.dart · widgets/
```

## Layer rules (dependency rule)

```
presentation ──► domain ◄── data
                   ▲
                 core (pure)          shared (UI) ──► core
```

- **domain** is pure Dart. It never imports `flutter`, `dio`, `flutter_map`, or platform channels. It uses `GeoPoint` rather than `LatLng`.
- **data** implements domain interfaces. It throws *data exceptions* (`LocationException`, `RoutingException`), and the repository translates them into *domain failures*.
- **presentation** depends only on domain use cases and entities, through constructor injection.
- Features never import each other's `data` layer. The `map` feature composes the others through their domain and presentation APIs.
- Only `app/` (the composition root) reads from `getIt`. Everything else receives dependencies through constructors.

## Error flow

```
Native/HTTP error ──► data exception (raw code) ──► repository maps ──► sealed Failure ──► Result.err
                                                                           │
                                         UI: exhaustive switch on failure type (no string parsing)
```

- `LocationFailure`: `PermissionDenied`, `PermissionDeniedForever`, `ServiceDisabled`, `Timeout`, `NotSupported`, `Unavailable`, `Unknown`
- `RoutingFailure`: `NoRouteFound`, `Network`, `Timeout`, `RateLimited`, `Server`, `BadResponse`, `Cancelled`

## SOLID, applied

| Principle | Where |
|---|---|
| **S**ingle responsibility | One use case per action (`GetCurrentLocation`, `GetDrivingRoute`, …). `PolylineDecoder` and `RateLimiter` each do exactly one thing. The channel datasource is the *only* class touching channels. |
| **O**pen/closed | `Failure` is an open base class; each feature adds its own sealed hierarchy without touching core. Adding iOS means implementing the channel contract natively, with zero Dart changes. |
| **L**iskov | Every repository/datasource implementation is fully substitutable for its interface. Tests swap in fakes without behavioural assumptions. |
| **I**nterface segregation | `LocationRepository` and `RoutingRepository` are separate, small interfaces. `AppLogger` exposes only what features need. |
| **D**ependency inversion | Domain defines `abstract interface` repositories. Data implements them with `@LazySingleton(as: Interface)`. Blocs depend on use cases, never on implementations. |

## Flavors

- `assets/config/dev.json` and `prod.json` hold the app name, package name, OSRM base URL, tile URL, timeouts, the DEV badge, and network logging.
- `FlavorConfigLoader.resolveFlavor()` reads `appFlavor` (set by `--flavor`). Debug builds fall back to `dev`; release builds fail fast if no flavor was given.
- `FlavorConfig` is registered with `@preResolve`, so it is ready before anything that needs it (e.g. Dio's `baseUrl`).
- Android `productFlavors` (app name and application ID) are configured in the native step.

## Key design decisions

- **Stale route responses:** `OsrmRemoteDataSource` cancels the previous `CancelToken` whenever a new request starts. The superseded call resolves to `RoutingCancelled`, which the UI ignores. The bloc will also keep a request id as a second guard.
- **OSRM rate limit:** the routing bloc will debounce long-presses inside a restartable handler and use `RateLimiter` (at least 1 s between calls).
- **Animation testability:** `NavigationFrame` and the upcoming `RouteGeometry`/`RouteAnimator` are pure Dart, driven by `tick(dt)`. Only a thin bloc bridge owns the Flutter `Ticker`.

## Code generation

```
dart run build_runner build      # freezed, json, retrofit, injectable
dart run build_runner watch      # during development
```
