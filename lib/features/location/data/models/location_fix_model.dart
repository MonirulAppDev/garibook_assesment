import '../../../../core/geo/geo_point.dart';
import '../../domain/entities/location_fix.dart';
import '../datasources/location_channel_contract.dart';
import 'location_exception.dart';

abstract final class LocationFixModel {
  static LocationFix fromChannel(Object? raw) {
    if (raw is! Map) {
      throw const LocationException.malformed('Fix payload is not a map');
    }
    final lat = _num(raw[LocationChannelContract.keyLatitude]);
    final lng = _num(raw[LocationChannelContract.keyLongitude]);
    if (lat == null || lng == null) {
      throw const LocationException.malformed('Fix without coordinates');
    }
    final position = GeoPoint(latitude: lat, longitude: lng);
    if (!position.isValid) {
      throw const LocationException.malformed('Fix with invalid coordinates');
    }
    final ts = _num(raw[LocationChannelContract.keyTimestampMs]);
    return LocationFix(
      position: position,
      accuracyMeters: _num(raw[LocationChannelContract.keyAccuracy]) ?? double.infinity,
      timestamp: ts == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(ts.toInt()),
      bearingDegrees: _num(raw[LocationChannelContract.keyBearing]),
      speedMps: _num(raw[LocationChannelContract.keySpeed]),
      isMock: raw[LocationChannelContract.keyIsMock] == true,
    );
  }

  static double? _num(Object? v) {
    if (v is! num) return null;
    final d = v.toDouble();
    return d.isFinite ? d : null;
  }
}
