import 'package:flutter_test/flutter_test.dart';
import 'package:garibook_assesment/core/geo/geo_point.dart';
import 'package:garibook_assesment/features/navigation/domain/engine/bearing_smoother.dart';
import 'package:garibook_assesment/features/navigation/domain/engine/route_animator.dart';
import 'package:garibook_assesment/features/navigation/domain/engine/route_geometry.dart';
import 'package:garibook_assesment/features/navigation/domain/entities/navigation_status.dart';

GeoPoint p(double lat, double lng) => GeoPoint(latitude: lat, longitude: lng);

const frame = Duration(milliseconds: 16);

RouteAnimator animatorFor(
  List<GeoPoint> points, {
  double baseSpeed = 20,
  double etaSpeed = 10,
}) =>
    RouteAnimator(
      geometry: RouteGeometry.fromPoints(points),
      etaSpeedMps: etaSpeed,
      baseSpeedMps: baseSpeed,
    );

void run(RouteAnimator a, int frames, [Duration dt = frame]) {
  for (var i = 0; i < frames; i++) {
    a.tick(dt);
  }
}

List<GeoPoint> line(int segments) => [
      for (var i = 0; i <= segments; i++) p(0, 0.01 * i / segments),
    ];

void main() {
  test('speed is constant regardless of point density', () {
    final sparse = animatorFor(line(1))..start();
    final dense = animatorFor(line(500))..start();
    run(sparse, 120);
    run(dense, 120);

    expect(sparse.travelled, closeTo(20 * 120 * 0.016, 1e-6));
    expect(dense.travelled, closeTo(sparse.travelled, 1e-6));
    expect(
      dense.frame.position.longitude,
      closeTo(sparse.frame.position.longitude, 1e-9),
    );
  });

  test('speed multiplier scales distance per tick', () {
    final a = animatorFor(line(10))..start();
    run(a, 10);
    final at1x = a.travelled;

    a.setSpeed(SpeedMultiplier.x5);
    run(a, 10);
    expect(a.travelled - at1x, closeTo(at1x * 5, 1e-6));
  });

  test('pause freezes progress; resume continues', () {
    final a = animatorFor(line(10))..start();
    run(a, 10);
    a.pause();
    final paused = a.travelled;
    run(a, 50);
    expect(a.travelled, paused);
    expect(a.status, NavigationStatus.paused);

    a.resume();
    run(a, 1);
    expect(a.travelled, greaterThan(paused));
  });

  test('a huge time gap (background) is clamped to one max step', () {
    final a = animatorFor(line(10))..start();
    a.tick(const Duration(minutes: 5));
    expect(a.travelled, closeTo(20 * 0.1, 1e-9));
  });

  test('finishes exactly at the end and stops advancing', () {
    final a = animatorFor(line(3), baseSpeed: 1000)..start();
    run(a, 1000);
    expect(a.status, NavigationStatus.finished);
    expect(a.remaining, 0);
    expect(a.frame.position.longitude, closeTo(0.01, 1e-12));
    expect(a.tick(frame), isFalse);
  });

  test('start after finish restarts; reset returns to idle at start', () {
    final a = animatorFor(line(3), baseSpeed: 1000)..start();
    run(a, 1000);
    a.start();
    expect(a.status, NavigationStatus.playing);
    expect(a.travelled, 0);

    run(a, 5);
    a.reset();
    expect(a.status, NavigationStatus.idle);
    expect(a.travelled, 0);
    expect(a.tick(frame), isFalse);
  });

  test('remaining time uses the router ETA speed, not the demo speed', () {
    final a = animatorFor(line(1), baseSpeed: 100, etaSpeed: 10);
    final total = a.remaining;
    expect(
      a.frame.remainingTime.inMilliseconds,
      closeTo(total / 10 * 1000, 1),
    );
  });

  test('messy route (repeats, near-duplicates) never yields NaN', () {
    final a = animatorFor(
      [
        p(0, 0),
        p(0, 0),
        p(0, 0.0000001),
        p(0, 0.001),
        p(0, 0.001),
        p(0.001, 0.001),
        p(0.001, 0.001),
      ],
      baseSpeed: 50,
    )..start();
    for (var i = 0; i < 400; i++) {
      a.tick(frame);
      final f = a.frame;
      expect(f.position.latitude.isFinite, isTrue);
      expect(f.position.longitude.isFinite, isTrue);
      expect(f.bearingDegrees.isFinite, isTrue);
      expect(f.remainingMeters.isFinite, isTrue);
      expect(f.progress.isFinite, isTrue);
    }
    expect(a.status, NavigationStatus.finished);
  });

  test('degenerate route finishes immediately on start', () {
    final a = animatorFor([p(1, 1), p(1, 1)])..start();
    expect(a.status, NavigationStatus.finished);
    expect(a.frame.progress, 1);
  });

  group('BearingSmoother', () {
    test('turns the short way across north', () {
      final s = BearingSmoother(initial: 359, maxDegreesPerSecond: 1000);
      s.step(1, 0.001);
      expect(s.value, closeTo(0, 1e-9));
      s.step(1, 0.001);
      expect(s.value, closeTo(1, 1e-9));
    });

    test('rate is bounded and frame-rate independent', () {
      final a = BearingSmoother(maxDegreesPerSecond: 90);
      final b = BearingSmoother(maxDegreesPerSecond: 90);
      a.step(180, 1.0);
      for (var i = 0; i < 100; i++) {
        b.step(180, 0.01);
      }
      expect(a.value, closeTo(90, 1e-9));
      expect(b.value, closeTo(90, 1e-6));
    });
  });
}
