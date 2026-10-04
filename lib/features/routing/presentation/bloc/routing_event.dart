part of 'routing_bloc.dart';

sealed class RoutingEvent {
  const RoutingEvent();
}

final class RouteMapLongPressed extends RoutingEvent {
  const RouteMapLongPressed(this.point);
  final GeoPoint point;
}

final class RouteDeviceLocationChanged extends RoutingEvent {
  const RouteDeviceLocationChanged(this.location);
  final GeoPoint? location;
}

final class RouteUseDeviceLocationRequested extends RoutingEvent {
  const RouteUseDeviceLocationRequested();
}

final class RouteRerouteRequested extends RoutingEvent {
  const RouteRerouteRequested(this.from);
  final GeoPoint from;
}

final class RouteRetryRequested extends RoutingEvent {
  const RouteRetryRequested();
}

final class RouteCleared extends RoutingEvent {
  const RouteCleared();
}

final class _RouteFetchRequested extends RoutingEvent {
  const _RouteFetchRequested();
}

final class _RouteSlowDetected extends RoutingEvent {
  const _RouteSlowDetected(this.requestId);
  final int requestId;
}
