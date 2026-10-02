import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/geo/geo_point.dart';

part 'location_fix.freezed.dart';

/// A single position reading from the device.
@freezed
abstract class LocationFix with _$LocationFix {
  const factory LocationFix({
    required GeoPoint position,
    required double accuracyMeters,
    required DateTime timestamp,
    double? bearingDegrees,
    double? speedMps,
    @Default(false) bool isMock,
  }) = _LocationFix;
}
