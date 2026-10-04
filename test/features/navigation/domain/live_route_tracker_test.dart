import 'package:flutter_test/flutter_test.dart';
import 'package:garibook_assesment/core/geo/geo_point.dart';
import 'package:garibook_assesment/features/navigation/domain/engine/live_route_tracker.dart';
import 'package:garibook_assesment/features/navigation/domain/engine/route_geometry.dart';
import 'package:garibook_assesment/features/navigation/domain/entities/live_position.dart';
import 'package:garibook_assesment/features/navigation/domain/entities/navigation_status.dart';

GeoPoint p(double lat, double lng) => GeoPoint(latitude: lat, longitude: lng);

const metre = 0.000009;

final road = RouteGeometry.fromPoints([
  for (var i = 0; i <= 100; i++) p(0, 0.01 * i / 100),
]);

LiveRouteTracker tracker() =>
    LiveRouteTracker(geometry: road, etaSpeedMps: 10)..start();

LivePosition at(double lat, double lng, {double? accuracy = 5}) =>
    LivePosition(point: p(lat, lng), accuracyMeters: accuracy);

void settle(LiveRouteTracker t) {
  for (var i = 0; i < 120; i++) {
    t.tick(const Duration(milliseconds: 16));
  }
}

void main() {
  group('RouteGeometry.project', () {
    test('snaps a point beside the road onto it', () {
      final proj = road.project(p(20 * metre, 0.005))!;
      expect(proj.point.latitude, closeTo(0, 1e-9));
      expect(proj.point.longitude, closeTo(0.005, 1e-9));
      expect(proj.offsetMeters, closeTo(20, 0.5));
      expect(proj.distanceAlong, closeTo(road.totalLength / 2, 1));
      expect(proj.bearing, closeTo(90, 1e-6));
    });

    test('clamps to route ends', () {
      final before = road.project(p(0, -0.001))!;
      expect(before.distanceAlong, 0);
      final after = road.project(p(0, 0.02))!;
      expect(after.distanceAlong, closeTo(road.totalLength, 1e-6));
    });

    test('empty route returns null', () {
      expect(RouteGeometry.fromPoints(const []).project(p(0, 0)), isNull);
    });
  });

  test('a slightly-off fix is displayed snapped onto the route', () {
    final t = tracker()..onPosition(at(15 * metre, 0.003));
    expect(t.frame.position.latitude, closeTo(0, 1e-9));
    expect(t.frame.position.longitude, closeTo(0.003, 1e-9));
  });

  test('glides between fixes along the road instead of jumping', () {
    final t = tracker()
      ..onPosition(at(0, 0.002))
      ..onPosition(at(0, 0.004));
    t.tick(const Duration(milliseconds: 500));
    expect(t.frame.position.longitude, closeTo(0.003, 1e-6));
    settle(t);
    expect(t.frame.position.longitude, closeTo(0.004, 1e-9));
  });

  test('off-route needs consecutive reliable fixes, then re-arms', () {
    final t = tracker();
    const far = 80 * metre;
    expect(t.onPosition(at(far, 0.003)), isFalse);
    expect(t.onPosition(at(far, 0.0031)), isTrue);
    expect(t.onPosition(at(far, 0.0032)), isFalse);
    expect(t.onPosition(at(far, 0.0033)), isTrue);
  });

  test('inaccurate fixes never trigger off-route', () {
    final t = tracker();
    for (var i = 0; i < 5; i++) {
      expect(t.onPosition(at(80 * metre, 0.003, accuracy: 120)), isFalse);
    }
  });

  test('coming back near the route resets the off-route count', () {
    final t = tracker();
    expect(t.onPosition(at(80 * metre, 0.003)), isFalse);
    expect(t.onPosition(at(5 * metre, 0.0031)), isFalse);
    expect(t.onPosition(at(80 * metre, 0.0032)), isFalse);
  });

  test('far fixes are shown raw (not snapped)', () {
    final t = tracker()..onPosition(at(80 * metre, 0.003));
    expect(t.frame.position.latitude, closeTo(80 * metre, 1e-9));
  });

  test('arrives near the end of the route', () {
    final t = tracker()..onPosition(at(0, 0.00995));
    settle(t);
    expect(t.status, NavigationStatus.finished);
    expect(t.frame.remainingMeters, lessThan(20));
  });

  test('ignores fixes while paused or idle', () {
    final t = LiveRouteTracker(geometry: road, etaSpeedMps: 10);
    t.onPosition(at(0, 0.005));
    expect(t.frame.position, road.start);

    t
      ..start()
      ..pause()
      ..onPosition(at(0, 0.005));
    expect(t.frame.position, road.start);
  });

  test('frames stay finite for invalid input', () {
    final t = tracker()
      ..onPosition(
        const LivePosition(
          point: GeoPoint(latitude: double.nan, longitude: 0),
        ),
      );
    settle(t);
    final f = t.frame;
    expect(f.position.latitude.isFinite, isTrue);
    expect(f.bearingDegrees.isFinite, isTrue);
    expect(f.remainingMeters.isFinite, isTrue);
  });
}
