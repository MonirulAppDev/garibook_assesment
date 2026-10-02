import 'package:flutter_test/flutter_test.dart';
import 'package:garibook_assesment/core/geo/geo_point.dart';
import 'package:garibook_assesment/features/navigation/domain/entities/live_position.dart';
import 'package:garibook_assesment/features/navigation/domain/entities/navigation_status.dart';
import 'package:garibook_assesment/features/navigation/presentation/cubit/navigation_cubit.dart';
import 'package:garibook_assesment/features/routing/domain/entities/nav_route.dart';

const a = GeoPoint(latitude: 0, longitude: 0);
const b = GeoPoint(latitude: 0, longitude: 0.01);

const route = NavRoute(
  origin: a,
  destination: b,
  points: [a, b],
  distanceMeters: 1113,
  durationSeconds: 100,
);

const frame = Duration(milliseconds: 16);

void main() {
  late NavigationCubit cubit;

  setUp(() => cubit = NavigationCubit()..loadRoute(route));
  tearDown(() => cubit.close());

  test('loading a route shows an idle car at the start', () {
    expect(cubit.state.hasRoute, isTrue);
    expect(cubit.state.status, NavigationStatus.idle);
    expect(cubit.state.frame!.position, a);
  });

  test('ticks only advance while playing', () {
    cubit.tick(frame);
    expect(cubit.state.frame!.travelledMeters, 0);

    cubit
      ..start()
      ..tick(frame);
    expect(cubit.state.frame!.travelledMeters, greaterThan(0));
  });

  test('user pan stops following; recenter restores it', () {
    cubit.start();
    expect(cubit.state.following, isTrue);

    cubit.userMovedMap();
    expect(cubit.state.following, isFalse);

    cubit.recenter();
    expect(cubit.state.following, isTrue);
  });

  test('background auto-pauses; foreground resumes only if auto-paused', () {
    cubit
      ..start()
      ..appBackgrounded();
    expect(cubit.state.status, NavigationStatus.paused);
    cubit.appForegrounded();
    expect(cubit.state.status, NavigationStatus.playing);

    cubit
      ..pause()
      ..appBackgrounded()
      ..appForegrounded();
    expect(cubit.state.status, NavigationStatus.paused,
        reason: 'user pause is respected');
  });

  test('speed selection survives a new route', () {
    cubit
      ..setSpeed(SpeedMultiplier.x5)
      ..loadRoute(route);
    expect(cubit.state.speed, SpeedMultiplier.x5);
    expect(cubit.state.frame!.speed, SpeedMultiplier.x5);
  });

  test('clearing the route removes the car', () {
    cubit.loadRoute(null);
    expect(cubit.state.hasRoute, isFalse);
  });

  group('live GPS mode', () {
    const metre = 0.000009;
    LivePosition at(double lat, double lng) => LivePosition(
          point: GeoPoint(latitude: lat, longitude: lng),
          accuracyMeters: 5,
        );

    test('car follows device fixes, seeded from the last known position',
        () {
      cubit
        ..onLivePosition(at(0, 0.004))
        ..setMode(DriveMode.live)
        ..start();
      expect(cubit.state.isLive, isTrue);
      expect(cubit.state.frame!.position.longitude, closeTo(0.004, 1e-9));
    });

    test('off-route requests a re-route, respecting the cooldown', () async {
      var now = DateTime(2026);
      await cubit.close();
      cubit = NavigationCubit(now: () => now)
        ..loadRoute(route)
        ..setMode(DriveMode.live)
        ..start();

      for (var i = 0; i < 2; i++) {
        cubit.onLivePosition(at(80 * metre, 0.003));
      }
      expect(cubit.state.rerouteRequests, 1);
      expect(cubit.state.rerouteFrom!.latitude, closeTo(80 * metre, 1e-12));

      for (var i = 0; i < 2; i++) {
        cubit.onLivePosition(at(80 * metre, 0.003));
      }
      expect(cubit.state.rerouteRequests, 1, reason: 'cooldown');

      now = now.add(const Duration(seconds: 16));
      for (var i = 0; i < 2; i++) {
        cubit.onLivePosition(at(80 * metre, 0.003));
      }
      expect(cubit.state.rerouteRequests, 2);
    });

    test('a new route keeps an active live session tracking', () {
      cubit
        ..setMode(DriveMode.live)
        ..start()
        ..loadRoute(route);
      expect(cubit.state.status, NavigationStatus.playing);
    });

    test('simulation ignores device fixes', () {
      cubit
        ..start()
        ..onLivePosition(at(0, 0.008));
      expect(cubit.state.frame!.position.longitude, closeTo(0, 1e-9));
    });
  });

  test('tick after close is ignored (no emit after dispose)', () async {
    cubit.start();
    await cubit.close();
    expect(() => cubit.tick(frame), returnsNormally);
  });
}
