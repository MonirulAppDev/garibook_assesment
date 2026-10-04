import '../../../../core/geo/geo_point.dart';

final class LivePosition {
  const LivePosition({
    required this.point,
    this.accuracyMeters,
    this.headingDegrees,
  });

  final GeoPoint point;
  final double? accuracyMeters;

  final double? headingDegrees;
}
