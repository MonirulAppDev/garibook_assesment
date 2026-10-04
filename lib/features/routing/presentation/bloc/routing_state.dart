part of 'routing_bloc.dart';

enum RouteStatus { idle, loading, success, failure }

@freezed
abstract class RoutingState with _$RoutingState {
  const factory RoutingState({
    GeoPoint? manualOrigin,
    GeoPoint? deviceLocation,
    GeoPoint? destination,
    @Default(RouteStatus.idle) RouteStatus status,

    @Default(false) bool isSlow,

    NavRoute? route,
    RoutingFailure? failure,
  }) = _RoutingState;

  const RoutingState._();

  GeoPoint? get origin => manualOrigin ?? deviceLocation;

  bool get usesManualOrigin => manualOrigin != null;

  bool get isLoading => status == RouteStatus.loading;
}
