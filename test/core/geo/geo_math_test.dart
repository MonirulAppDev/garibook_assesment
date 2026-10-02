import 'package:flutter_test/flutter_test.dart';
import 'package:garibook_assesment/core/geo/geo_math.dart';
import 'package:garibook_assesment/core/geo/geo_point.dart';

GeoPoint p(double lat, double lng) => GeoPoint(latitude: lat, longitude: lng);

void main() {
  group('distance', () {
    test('one degree of latitude ≈ 111.2 km', () {
      expect(GeoMath.distance(p(0, 0), p(1, 0)), closeTo(111195, 10));
    });

    test('identical points are 0, not NaN', () {
      expect(GeoMath.distance(p(23.8, 90.4), p(23.8, 90.4)), 0);
    });
  });

  group('bearing', () {
    test('cardinal directions', () {
      expect(GeoMath.bearing(p(0, 0), p(1, 0)), closeTo(0, 1e-9));
      expect(GeoMath.bearing(p(0, 0), p(0, 1)), closeTo(90, 1e-9));
      expect(GeoMath.bearing(p(1, 0), p(0, 0)), closeTo(180, 1e-9));
      expect(GeoMath.bearing(p(0, 1), p(0, 0)), closeTo(270, 1e-9));
    });

    test('identical points yield 0, not NaN', () {
      expect(GeoMath.bearing(p(5, 5), p(5, 5)), 0);
    });
  });

  group('shortestAngleDelta', () {
    test('wraps across north the short way', () {
      expect(GeoMath.shortestAngleDelta(359, 1), closeTo(2, 1e-9));
      expect(GeoMath.shortestAngleDelta(1, 359), closeTo(-2, 1e-9));
    });

    test('handles same, opposite and unnormalized angles', () {
      expect(GeoMath.shortestAngleDelta(90, 90), 0);
      expect(GeoMath.shortestAngleDelta(0, 180).abs(), 180);
      expect(GeoMath.shortestAngleDelta(-10, 370), closeTo(20, 1e-9));
    });

    test('non-finite input yields 0', () {
      expect(GeoMath.shortestAngleDelta(double.nan, 10), 0);
    });
  });

  test('normalizeDegrees', () {
    expect(GeoMath.normalizeDegrees(-90), 270);
    expect(GeoMath.normalizeDegrees(720), 0);
    expect(GeoMath.normalizeDegrees(double.infinity), 0);
  });
}
