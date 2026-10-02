part of 'routing_bloc.dart';

enum RouteStatus { idle, loading, success, failure }

@freezed
abstract class RoutingState with _$RoutingState {
  const factory RoutingState({
    /// Start point chosen by long-press when no device location is usable.
    GeoPoint? manualOrigin,
    GeoPoint? deviceLocation,
    GeoPoint? destination,
    @Default(RouteStatus.idle) RouteStatus status,

    /// The current request is taking longer than expected.
    @Default(false) bool isSlow,

    /// Last successful route. Kept on failure so an ongoing navigation
    /// isn't torn down by a failed re-route.
    NavRoute? route,
    RoutingFailure? failure,
  }) = _RoutingState;

  const RoutingState._();

  /// Manual start wins; otherwise the device location.
  GeoPoint? get origin => manualOrigin ?? deviceLocation;

  bool get usesManualOrigin => manualOrigin != null;

  bool get isLoading => status == RouteStatus.loading;
}
