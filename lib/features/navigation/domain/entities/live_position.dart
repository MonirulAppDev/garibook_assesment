import '../../../../core/geo/geo_point.dart';

/// A device position as the navigation feature needs it. Keeps this
/// feature independent of the location feature's types.
final class LivePosition {
  const LivePosition({
    required this.point,
    this.accuracyMeters,
    this.headingDegrees,
  });

  final GeoPoint point;
  final double? accuracyMeters;

  /// Device-reported course; only meaningful while moving.
  final double? headingDegrees;
}
