import 'package:freezed_annotation/freezed_annotation.dart';

part 'geo_point.freezed.dart';

/// Framework-agnostic WGS84 coordinate used by every domain layer.
///
/// Kept independent from map packages so domain logic (routing,
/// animation) stays pure Dart and testable.
@freezed
abstract class GeoPoint with _$GeoPoint {
  const factory GeoPoint({
    required double latitude,
    required double longitude,
  }) = _GeoPoint;

  const GeoPoint._();

  bool get isValid =>
      latitude.isFinite &&
      longitude.isFinite &&
      latitude.abs() <= 90 &&
      longitude.abs() <= 180;
}
