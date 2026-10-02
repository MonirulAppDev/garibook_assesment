part of 'routing_bloc.dart';

sealed class RoutingEvent {
  const RoutingEvent();
}

/// Long-press on the map. Sets the manual start point when no origin is
/// available yet, otherwise sets the destination and fetches a route.
final class RouteMapLongPressed extends RoutingEvent {
  const RouteMapLongPressed(this.point);
  final GeoPoint point;
}

/// Latest device position (or null when it becomes unavailable).
final class RouteDeviceLocationChanged extends RoutingEvent {
  const RouteDeviceLocationChanged(this.location);
  final GeoPoint? location;
}

/// Drop the manual start point and route from the device location.
final class RouteUseDeviceLocationRequested extends RoutingEvent {
  const RouteUseDeviceLocationRequested();
}

/// Live navigation left the route: re-plan from [from] (the device
/// position) to the current destination.
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
