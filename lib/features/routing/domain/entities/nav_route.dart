import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/geo/geo_point.dart';

part 'nav_route.freezed.dart';

/// A drivable route between two points.
@freezed
abstract class NavRoute with _$NavRoute {
  const factory NavRoute({
    required GeoPoint origin,
    required GeoPoint destination,
    required List<GeoPoint> points,
    required double distanceMeters,
    required double durationSeconds,
  }) = _NavRoute;

  const NavRoute._();

  /// Average speed implied by the router; used for live ETA.
  /// Guarded so a zero duration can never yield NaN/Infinity.
  double get averageSpeedMps =>
      durationSeconds > 0 && distanceMeters.isFinite
          ? distanceMeters / durationSeconds
          : 0;
}
