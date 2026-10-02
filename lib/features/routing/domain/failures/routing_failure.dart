import '../../../../core/error/failure.dart';

sealed class RoutingFailure extends Failure {
  const RoutingFailure(super.message);
}

final class NoRouteFound extends RoutingFailure {
  const NoRouteFound([super.message = 'No drivable route between the points']);
}

final class RoutingNetworkFailure extends RoutingFailure {
  const RoutingNetworkFailure([super.message = 'Network unavailable']);
}

final class RoutingTimeout extends RoutingFailure {
  const RoutingTimeout([super.message = 'Routing server took too long']);
}

final class RoutingRateLimited extends RoutingFailure {
  const RoutingRateLimited([super.message = 'Too many routing requests']);
}

final class RoutingServerFailure extends RoutingFailure {
  const RoutingServerFailure([super.message = 'Routing server error']);
}

final class RoutingBadResponse extends RoutingFailure {
  const RoutingBadResponse([super.message = 'Unexpected routing response']);
}

/// A newer request superseded this one. Not an error for the user.
final class RoutingCancelled extends RoutingFailure {
  const RoutingCancelled() : super('Superseded by a newer request');
}
