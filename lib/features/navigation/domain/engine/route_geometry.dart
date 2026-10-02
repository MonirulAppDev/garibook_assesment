import '../../../../core/geo/geo_math.dart';
import '../../../../core/geo/geo_point.dart';

/// A position on the route: where, and which way the road is heading.
typedef RoutePosition = ({GeoPoint point, double bearing});

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
