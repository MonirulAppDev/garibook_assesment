import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:garibook_assesment/core/geo/geo_point.dart';
import 'package:garibook_assesment/core/result/result.dart';
import 'package:garibook_assesment/features/location/domain/entities/location_fix.dart';
import 'package:garibook_assesment/features/location/domain/entities/location_permission_status.dart';
import 'package:garibook_assesment/features/location/domain/entities/location_request_options.dart';
import 'package:garibook_assesment/features/location/domain/failures/location_failure.dart';
import 'package:garibook_assesment/features/location/domain/repositories/location_repository.dart';
import 'package:garibook_assesment/features/location/domain/usecases/location_usecases.dart';
import 'package:garibook_assesment/features/location/presentation/bloc/location_bloc.dart';

class FakeLocationRepository implements LocationRepository {
  Result<LocationPermissionStatus> checkResult =
      const Ok(LocationPermissionStatus.denied);
  Result<LocationPermissionStatus> requestResult =
      const Ok(LocationPermissionStatus.granted);
  Result<bool> serviceResult = const Ok(true);
  Result<LocationFix>? currentResult;

  int requestCalls = 0;
  int listenCount = 0;
  int cancelCount = 0;
  // Closed by the bloc cancelling its subscription.
  // ignore: close_sinks
  StreamController<Result<LocationFix>>? controller;

  @override
  Future<Result<LocationPermissionStatus>> checkPermission() async =>
      checkResult;

  @override
  Future<Result<LocationPermissionStatus>> requestPermission() async {
    requestCalls++;
    return requestResult;
  }

  @override
  Future<Result<bool>> isServiceEnabled() async => serviceResult;

  @override
  Future<Result<LocationFix>> getCurrentLocation(
    LocationRequestOptions options,
  ) async =>
      currentResult ?? Ok(fixAt(1, 2));

  @override
  Stream<Result<LocationFix>> watchLocation(LocationRequestOptions options) {
    controller = StreamController<Result<LocationFix>>(
      onListen: () => listenCount++,
      onCancel: () => cancelCount++,
    );
    return controller!.stream;
  }

  @override
  Future<Result<bool>> openAppSettings() async => const Ok(true);

  @override
  Future<Result<bool>> openLocationSettings() async => const Ok(true);
}

LocationFix fixAt(double lat, double lng) => LocationFix(
      position: GeoPoint(latitude: lat, longitude: lng),
      accuracyMeters: 5,
      timestamp: DateTime(2026),
    );

Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 10));

void main() {
  late FakeLocationRepository repo;
  late LocationBloc bloc;

  setUp(() {
    repo = FakeLocationRepository();
    bloc = LocationBloc(
      CheckLocationPermission(repo),
      RequestLocationPermission(repo),
      IsLocationServiceEnabled(repo),
      GetCurrentLocation(repo),
      WatchLocation(repo),
      OpenAppSettings(repo),
      OpenLocationSettings(repo),
    );
  });

  tearDown(() => bloc.close());

  test('on start with no permission: explains first, never prompts', () async {
    bloc.add(const LocationStarted());
    await settle();

    expect(bloc.state.status, LocationStatus.needsPermission);
    expect(repo.requestCalls, 0);
  });

  test('already granted: acquires a fix and starts streaming', () async {
    repo.checkResult = const Ok(LocationPermissionStatus.granted);
    bloc.add(const LocationStarted());
    await settle();

    expect(bloc.state.status, LocationStatus.ready);
    expect(bloc.state.fix, fixAt(1, 2));
    expect(repo.listenCount, 1);

    repo.controller!.add(Ok(fixAt(3, 4)));
    await settle();
    expect(bloc.state.fix, fixAt(3, 4));
  });

  test('user enables: denied forever -> typed failure', () async {
    repo.requestResult = const Ok(LocationPermissionStatus.deniedForever);
    bloc.add(const LocationEnableRequested());
    await settle();

    expect(repo.requestCalls, 1);
    expect(bloc.state.status, LocationStatus.failure);
    expect(bloc.state.failure, isA<LocationPermissionDeniedForever>());
  });

  test('services off -> LocationServiceDisabled', () async {
    repo
      ..checkResult = const Ok(LocationPermissionStatus.granted)
      ..serviceResult = const Ok(false);
    bloc.add(const LocationStarted());
    await settle();

    expect(bloc.state.failure, isA<LocationServiceDisabled>());
  });

  test('no first fix in time -> LocationTimeout', () async {
    repo
      ..checkResult = const Ok(LocationPermissionStatus.granted)
      ..currentResult = const Err(LocationTimeout());
    bloc.add(const LocationStarted());
    await settle();

    expect(bloc.state.failure, isA<LocationTimeout>());
  });

  test('pause stops native updates; resume restarts them', () async {
    repo.checkResult = const Ok(LocationPermissionStatus.granted);
    bloc.add(const LocationStarted());
    await settle();
    expect(repo.listenCount, 1);

    bloc.add(const LocationAppPaused());
    await settle();
    expect(repo.cancelCount, 1);

    bloc.add(const LocationAppResumed());
    await settle();
    expect(repo.listenCount, 2);
  });

  test('resume after Settings re-checks a permanently denied permission',
      () async {
    repo.requestResult = const Ok(LocationPermissionStatus.deniedForever);
    bloc.add(const LocationEnableRequested());
    await settle();

    repo.checkResult = const Ok(LocationPermissionStatus.granted);
    bloc
      ..add(const LocationAppPaused())
      ..add(const LocationAppResumed());
    await settle();

    expect(bloc.state.status, LocationStatus.ready);
  });

  test('closing the bloc cancels the native stream', () async {
    repo.checkResult = const Ok(LocationPermissionStatus.granted);
    bloc.add(const LocationStarted());
    await settle();

    await bloc.close();
    expect(repo.cancelCount, 1);
  });
}
