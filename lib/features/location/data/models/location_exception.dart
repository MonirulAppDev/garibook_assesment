import '../datasources/location_channel_contract.dart';

final class LocationException implements Exception {
  const LocationException(this.code, [this.message]);

  const LocationException.notSupported()
      : code = notSupportedCode,
        message = 'No native location implementation registered';

  const LocationException.malformed(String this.message)
      : code = LocationChannelContract.errUnknown;

  static const notSupportedCode = 'NOT_SUPPORTED';

  final String code;
  final String? message;

  @override
  String toString() => 'LocationException($code, $message)';
}
