import '../../../../core/error/failure.dart';

sealed class LocationFailure extends Failure {
  const LocationFailure(super.message);
}

final class LocationPermissionDenied extends LocationFailure {
  const LocationPermissionDenied() : super('Location permission denied');
}

final class LocationPermissionDeniedForever extends LocationFailure {
  const LocationPermissionDeniedForever()
      : super('Location permission permanently denied');
}

final class LocationServiceDisabled extends LocationFailure {
  const LocationServiceDisabled() : super('Location services are off');
}

final class LocationTimeout extends LocationFailure {
  const LocationTimeout() : super('No location fix within the time limit');
}

final class LocationNotSupported extends LocationFailure {
  const LocationNotSupported()
      : super('Location is not supported on this platform');
}

final class LocationUnavailable extends LocationFailure {
  const LocationUnavailable(super.message);
}

final class LocationUnknownFailure extends LocationFailure {
  const LocationUnknownFailure(super.message);
}
