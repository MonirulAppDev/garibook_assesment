import 'package:flutter_test/flutter_test.dart';
import 'package:garibook_assesment/core/geo/geo_math.dart';
import 'package:garibook_assesment/core/geo/geo_point.dart';
import 'package:garibook_assesment/features/navigation/domain/engine/route_geometry.dart';

GeoPoint p(double lat, double lng) => GeoPoint(latitude: lat, longitude: lng);

void expectFinite(RoutePosition pos) {
  expect(pos.point.latitude.isFinite, isTrue);
  expect(pos.point.longitude.isFinite, isTrue);
  expect(pos.bearing.isFinite, isTrue);
}

void main() {
  test('removes duplicate and near-duplicate points', () {
    final g = RouteGeometry.fromPoints([
      p(0, 0),
      p(0, 0),
      p(0, 0.000001), // ~0.11 m
      p(0, 0.001),
      p(0, 0.001),
      p(0, 0.002),
    ]);
    expect(g.points, [p(0, 0), p(0, 0.001), p(0, 0.002)]);
  });

  test('drops invalid coordinates', () {
    final g = RouteGeometry.fromPoints([
      p(0, 0),
      const GeoPoint(latitude: double.nan, longitude: 0),
      const GeoPoint(latitude: 91, longitude: 0),
      p(0, 0.001),
    ]);
    expect(g.points, hasLength(2));
  });

  test('all-identical points -> degenerate, still no NaN', () {
    final g = RouteGeometry.fromPoints([p(1, 1), p(1, 1), p(1, 1)]);
    expect(g.isDegenerate, isTrue);
    expect(g.totalLength, 0);
    expectFinite(g.positionAt(10));
  });

  test('empty route does not throw', () {
    final g = RouteGeometry.fromPoints(const []);
    expect(g.isDegenerate, isTrue);
    expectFinite(g.positionAt(0));
  });

  group('positionAt', () {
    final g = RouteGeometry.fromPoints([p(0, 0), p(0, 0.01), p(0.01, 0.01)]);
    final leg = GeoMath.distance(p(0, 0), p(0, 0.01));

    test('start, middle of first leg, corner, end', () {
      expect(g.positionAt(0).point, p(0, 0));
      expect(g.positionAt(leg / 2).point.longitude, closeTo(0.005, 1e-9));
      expect(g.positionAt(leg / 2).bearing, closeTo(90, 1e-6));
      expect(g.positionAt(leg + 1).bearing, closeTo(0, 1e-3));
      expect(g.positionAt(g.totalLength).point, p(0.01, 0.01));
    });

    test('clamps out-of-range and non-finite distances', () {
      expect(g.positionAt(-50).point, p(0, 0));
      expect(g.positionAt(1e12).point, p(0.01, 0.01));
      expectFinite(g.positionAt(double.nan));
      expectFinite(g.positionAt(double.infinity));
    });

    test('every sampled position is finite', () {
      for (var d = 0.0; d <= g.totalLength; d += 7.3) {
        expectFinite(g.positionAt(d));
      }
    });
  });
}
