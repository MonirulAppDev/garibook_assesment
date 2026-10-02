import 'dart:math' as math;

import 'geo_point.dart';

/// Pure spherical-earth helpers. All outputs are finite for finite inputs.
abstract final class GeoMath {
  static const earthRadiusMeters = 6371008.8;
  static const _degToRad = math.pi / 180;
  static const _radToDeg = 180 / math.pi;

  /// Great-circle (haversine) distance in metres.
  static double distance(GeoPoint a, GeoPoint b) {
    final lat1 = a.latitude * _degToRad;
    final lat2 = b.latitude * _degToRad;
    final dLat = lat2 - lat1;
    final dLng = (b.longitude - a.longitude) * _degToRad;
    final sinLat = math.sin(dLat / 2);
    final sinLng = math.sin(dLng / 2);
    final h = sinLat * sinLat + math.cos(lat1) * math.cos(lat2) * sinLng * sinLng;
    // clamp guards asin against rounding slightly above 1.
    return 2 * earthRadiusMeters * math.asin(math.sqrt(h.clamp(0.0, 1.0)));
  }

  /// Initial bearing from [a] to [b] in degrees, `[0, 360)`.
  /// Identical points yield 0 rather than NaN.
  static double bearing(GeoPoint a, GeoPoint b) {
    final lat1 = a.latitude * _degToRad;
    final lat2 = b.latitude * _degToRad;
    final dLng = (b.longitude - a.longitude) * _degToRad;
    final y = math.sin(dLng) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLng);
    if (x == 0 && y == 0) return 0;
    return normalizeDegrees(math.atan2(y, x) * _radToDeg);
  }

  /// Linear interpolation; accurate enough over a single route segment.
  static GeoPoint lerp(GeoPoint a, GeoPoint b, double t) {
    final f = t.isFinite ? t.clamp(0.0, 1.0) : 0.0;
    return GeoPoint(
      latitude: a.latitude + (b.latitude - a.latitude) * f,
      longitude: a.longitude + (b.longitude - a.longitude) * f,
    );
  }

  /// Wraps any angle into `[0, 360)`.
  static double normalizeDegrees(double degrees) {
    if (!degrees.isFinite) return 0;
    final r = degrees % 360;
    return r < 0 ? r + 360 : r;
  }

  /// Signed smallest rotation from [from] to [to], in `(-180, 180]`.
  /// e.g. 359 → 1 is +2, never -358.
  static double shortestAngleDelta(double from, double to) {
    if (!from.isFinite || !to.isFinite) return 0;
    var d = (to - from) % 360;
    if (d > 180) d -= 360;
    return d;
  }
}
