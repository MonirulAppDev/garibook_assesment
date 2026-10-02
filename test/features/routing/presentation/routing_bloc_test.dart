import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:garibook_assesment/core/geo/geo_point.dart';
import 'package:garibook_assesment/core/result/result.dart';
import 'package:garibook_assesment/features/routing/domain/entities/nav_route.dart';
import 'package:garibook_assesment/features/routing/domain/failures/routing_failure.dart';
import 'package:garibook_assesment/features/routing/domain/repositories/routing_repository.dart';
import 'package:garibook_assesment/features/routing/domain/usecases/get_driving_route.dart';
import 'package:garibook_assesment/features/routing/presentation/bloc/routing_bloc.dart';

class FakeRoutingRepository implements RoutingRepository {
  final calls = <({GeoPoint from, GeoPoint to})>[];
  final pending = <Completer<Result<NavRoute>>>[];

  @override
  Future<Result<NavRoute>> getDrivingRoute({
    required GeoPoint from,
    required GeoPoint to,
  }) {
    calls.add((from: from, to: to));
    final c = Completer<Result<NavRoute>>();
    pending.add(c);
    return c.future;
  }
}

GeoPoint p(double lat, double lng) => GeoPoint(latitude: lat, longitude: lng);

NavRoute routeTo(GeoPoint from, GeoPoint to) => NavRoute(
      origin: from,
      destination: to,
      points: [from, to],
      distanceMeters: 1000,
      durationSeconds: 120,
    );

Future<void> wait(int ms) => Future<void>.delayed(Duration(milliseconds: ms));

void main() {
  late FakeRoutingRepository repo;
  late RoutingBloc bloc;

  final home = p(23.80, 90.40);
  final d1 = p(23.81, 90.41);
  final d2 = p(23.82, 90.42);
  final d3 = p(23.83, 90.43);

  RoutingBloc build({
    Duration debounce = const Duration(milliseconds: 10),
    Duration minInterval = Duration.zero,
    Duration slow = const Duration(seconds: 5),
  }) =>
      RoutingBloc(
        GetDrivingRoute(repo),
        debounce: debounce,
        minRequestInterval: minInterval,
        slowThreshold: slow,
      );

  setUp(() {
    repo = FakeRoutingRepository();
    bloc = build();
  });

  tearDown(() => bloc.close());

  test('without any origin, first long-press sets a manual start', () async {
    bloc.add(RouteMapLongPressed(d1));
    await wait(30);

    expect(bloc.state.manualOrigin, d1);
    expect(bloc.state.origin, d1);
    expect(repo.calls, isEmpty);

    bloc.add(RouteMapLongPressed(d2));
    await wait(30);
    expect(repo.calls.single, (from: d1, to: d2));
  });

  test('rapid long-presses are debounced into one request (last wins)',
      () async {
    bloc
      ..add(RouteDeviceLocationChanged(home))
      ..add(RouteMapLongPressed(d1))
      ..add(RouteMapLongPressed(d2))
      ..add(RouteMapLongPressed(d3));
    await wait(50);

    expect(repo.calls, hasLength(1));
    expect(repo.calls.single.to, d3);
    expect(bloc.state.isLoading, isTrue);
  });

  test('a slow older response never overwrites a newer one', () async {
    bloc
      ..add(RouteDeviceLocationChanged(home))
      ..add(RouteMapLongPressed(d1));
    await wait(30);
    bloc.add(RouteMapLongPressed(d2));
    await wait(30);
    expect(repo.calls, hasLength(2));

    repo.pending[1].complete(Ok(routeTo(home, d2)));
    await wait(5);
    repo.pending[0].complete(Ok(routeTo(home, d1)));
    await wait(5);

    expect(bloc.state.status, RouteStatus.success);
    expect(bloc.state.route!.destination, d2);
  });

  test('failure keeps the previous route and exposes a typed failure',
      () async {
    bloc
      ..add(RouteDeviceLocationChanged(home))
      ..add(RouteMapLongPressed(d1));
    await wait(30);
    repo.pending[0].complete(Ok(routeTo(home, d1)));
    await wait(5);

    bloc.add(RouteMapLongPressed(d2));
    await wait(30);
    repo.pending[1].complete(const Err(NoRouteFound()));
    await wait(5);

    expect(bloc.state.status, RouteStatus.failure);
    expect(bloc.state.failure, isA<NoRouteFound>());
    expect(bloc.state.route!.destination, d1);
  });

  test('a cancelled (superseded) result is ignored', () async {
    bloc
      ..add(RouteDeviceLocationChanged(home))
      ..add(RouteMapLongPressed(d1));
    await wait(30);
    repo.pending[0].complete(const Err(RoutingCancelled()));
    await wait(5);

    expect(bloc.state.status, RouteStatus.loading);
    expect(bloc.state.failure, isNull);
  });

  test('flags slow responses', () async {
    await bloc.close();
    bloc = build(slow: const Duration(milliseconds: 20));
    bloc
      ..add(RouteDeviceLocationChanged(home))
      ..add(RouteMapLongPressed(d1));
    await wait(80);

    expect(bloc.state.isLoading, isTrue);
    expect(bloc.state.isSlow, isTrue);
  });

  test('enforces the minimum interval between requests', () async {
    await bloc.close();
    bloc = build(minInterval: const Duration(milliseconds: 300));
    bloc
      ..add(RouteDeviceLocationChanged(home))
      ..add(RouteMapLongPressed(d1));
    await wait(30);
    repo.pending[0].complete(Ok(routeTo(home, d1)));
    expect(repo.calls, hasLength(1));

    bloc.add(RouteMapLongPressed(d2));
    await wait(100);
    expect(repo.calls, hasLength(1), reason: 'still rate limited');

    await wait(300);
    expect(repo.calls, hasLength(2));
  });

  test('clear invalidates the in-flight request', () async {
    bloc
      ..add(RouteDeviceLocationChanged(home))
      ..add(RouteMapLongPressed(d1));
    await wait(30);
    bloc.add(const RouteCleared());
    await wait(5);
    repo.pending[0].complete(Ok(routeTo(home, d1)));
    await wait(5);

    expect(bloc.state.route, isNull);
    expect(bloc.state.destination, isNull);
    expect(bloc.state.deviceLocation, home);
  });
}
