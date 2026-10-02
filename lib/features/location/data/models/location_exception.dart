import '../datasources/location_channel_contract.dart';

/// Data-layer error carrying the raw native contract code.
/// The repository translates it into a domain `LocationFailure`.
final class LocationException implements Exception {
  const LocationException(this.code, [this.message]);

  const LocationException.notSupported()
      : code = notSupportedCode,
        message = 'No native location implementation registered';

  const LocationException.malformed(String this.message)
      : code = LocationChannelContract.errUnknown;

  /// Dart-side code: the platform has no channel handler at all.
  static const notSupportedCode = 'NOT_SUPPORTED';

  final String code;
  final String? message;

  @override
  String toString() => 'LocationException($code, $message)';
}
