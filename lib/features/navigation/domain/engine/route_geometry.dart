import 'dart:math' as math;

import '../../../../core/geo/geo_math.dart';
import '../../../../core/geo/geo_point.dart';

/// A position on the route: where, and which way the road is heading.
typedef RoutePosition = ({GeoPoint point, double bearing});

/// Result of snapping an arbitrary point onto the route.
typedef RouteProjection = ({
  GeoPoint point,
  double distanceAlong,
  double offsetMeters,
  double bearing,
});

/// Cleaned route polyline with precomputed cumulative distances, so any
/// position can be looked up by *distance travelled* in O(log n).
///
/// Moving by distance (not by point index) is what keeps the car's speed
/// constant regardless of how dense or sparse the route points are.
final class RouteGeometry {
  RouteGeometry._(this.points, this._cumulative, this._bearings);

  /// Builds geometry from raw router output.
  ///
  /// Robustness: drops non-finite/invalid coordinates and any point closer
  /// than [minSpacingMeters] to the previously kept one (duplicates and
  /// near-duplicates). Every remaining segment therefore has a positive
  /// length, so interpolation never divides by zero.
  factory RouteGeometry.fromPoints(
    List<GeoPoint> raw, {
    double minSpacingMeters = 0.5,
  }) {
    final points = <GeoPoint>[];
    for (final p in raw) {
      if (!p.isValid) continue;
      if (points.isNotEmpty &&
          GeoMath.distance(points.last, p) < minSpacingMeters) {
        continue;
      }
      points.add(p);
    }

    final cumulative = <double>[if (points.isNotEmpty) 0];
    final bearings = <double>[];
    for (var i = 1; i < points.length; i++) {
      cumulative.add(cumulative.last + GeoMath.distance(points[i - 1], points[i]));
      bearings.add(GeoMath.bearing(points[i - 1], points[i]));
    }
    return RouteGeometry._(
      List.unmodifiable(points),
      List.unmodifiable(cumulative),
      List.unmodifiable(bearings),
    );
  }

  final List<GeoPoint> points;
  final List<double> _cumulative;
  final List<double> _bearings;

  double get totalLength => _cumulative.isEmpty ? 0 : _cumulative.last;

  /// Fewer than two distinct points: nothing to animate along.
  bool get isDegenerate => points.length < 2;

  GeoPoint? get start => points.isEmpty ? null : points.first;

  double get initialBearing => _bearings.isEmpty ? 0 : _bearings.first;

  /// Position after travelling [distance] metres from the start.
  /// Out-of-range distances are clamped to the route ends.
  RoutePosition positionAt(double distance) {
    if (points.isEmpty) {
      return (point: const GeoPoint(latitude: 0, longitude: 0), bearing: 0);
    }
    if (isDegenerate) return (point: points.first, bearing: 0);

    final d = distance.isFinite ? distance.clamp(0.0, totalLength) : 0.0;
    final i = _segmentIndexAt(d);
    final segStart = _cumulative[i];
    final segLength = _cumulative[i + 1] - segStart;
    final t = segLength > 0 ? (d - segStart) / segLength : 0.0;
    return (
      point: GeoMath.lerp(points[i], points[i + 1], t),
      bearing: _bearings[i],
    );
  }

  /// Nearest point on the route to [p] (snap-to-route).
  ///
  /// Each segment is projected in a local equirectangular plane centred on
  /// its start, which is accurate to centimetres at segment scale.
  /// Returns null for an empty route.
  RouteProjection? project(GeoPoint p) {
    if (points.isEmpty || !p.isValid) return null;
    if (isDegenerate) {
      return (
        point: points.first,
        distanceAlong: 0,
        offsetMeters: GeoMath.distance(points.first, p),
        bearing: 0,
      );
    }

    RouteProjection? best;
    for (var i = 0; i < points.length - 1; i++) {
      final a = points[i];
      final b = points[i + 1];
      final cosLat = math.cos(a.latitude * math.pi / 180);
      // Planar metres relative to a.
      final bx = (b.longitude - a.longitude) * cosLat * _metersPerDegree;
      final by = (b.latitude - a.latitude) * _metersPerDegree;
      final px = (p.longitude - a.longitude) * cosLat * _metersPerDegree;
      final py = (p.latitude - a.latitude) * _metersPerDegree;
      final len2 = bx * bx + by * by;
      final t = len2 > 0 ? ((px * bx + py * by) / len2).clamp(0.0, 1.0) : 0.0;
      final dx = px - bx * t;
      final dy = py - by * t;
      final offset = math.sqrt(dx * dx + dy * dy);
      if (best == null || offset < best.offsetMeters) {
        best = (
          point: GeoMath.lerp(a, b, t),
          distanceAlong: _cumulative[i] + (_cumulative[i + 1] - _cumulative[i]) * t,
          offsetMeters: offset,
          bearing: _bearings[i],
        );
      }
    }
    return best;
  }

  static const _metersPerDegree = GeoMath.earthRadiusMeters * math.pi / 180;

  /// Largest segment index `i` with `cumulative[i] <= d`.
  int _segmentIndexAt(double d) {
    var lo = 0;
    var hi = _cumulative.length - 2; // last segment index
    while (lo < hi) {
      final mid = (lo + hi + 1) >> 1;
      if (_cumulative[mid] <= d) {
        lo = mid;
      } else {
        hi = mid - 1;
      }
    }
    return lo;
  }
}
