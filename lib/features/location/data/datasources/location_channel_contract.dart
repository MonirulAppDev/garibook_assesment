abstract final class LocationChannelContract {
  static const methodChannel = 'navtest/location';
  static const eventChannel = 'navtest/location/updates';

  static const checkPermission = 'checkPermission';
  static const requestPermission = 'requestPermission';
  static const isServiceEnabled = 'isLocationServiceEnabled';
  static const getCurrentLocation = 'getCurrentLocation';
  static const openAppSettings = 'openAppSettings';
  static const openLocationSettings = 'openLocationSettings';

  static const argHighAccuracy = 'highAccuracy';
  static const argTimeoutMs = 'timeoutMs';
  static const argIntervalMs = 'intervalMs';
  static const argMinDistanceM = 'minDistanceM';

  static const permissionGranted = 'granted';
  static const permissionGrantedApproximate = 'grantedApproximate';
  static const permissionDenied = 'denied';
  static const permissionDeniedForever = 'deniedForever';

  static const errPermissionDenied = 'PERMISSION_DENIED';
  static const errPermissionDeniedForever = 'PERMISSION_DENIED_FOREVER';
  static const errServicesDisabled = 'SERVICES_DISABLED';
  static const errTimeout = 'TIMEOUT';
  static const errRequestInProgress = 'PERMISSION_REQUEST_IN_PROGRESS';
  static const errNoActivity = 'NO_ACTIVITY';
  static const errPlayServicesUnavailable = 'PLAY_SERVICES_UNAVAILABLE';
  static const errUnknown = 'UNKNOWN';

  static const keyLatitude = 'latitude';
  static const keyLongitude = 'longitude';
  static const keyAccuracy = 'accuracy';
  static const keyBearing = 'bearing';
  static const keySpeed = 'speed';
  static const keyTimestampMs = 'timestampMs';
  static const keyIsMock = 'isMock';
}
