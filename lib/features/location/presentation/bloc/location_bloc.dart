import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/location_fix.dart';
import '../../domain/entities/location_permission_status.dart';
import '../../domain/entities/location_request_options.dart';
import '../../domain/failures/location_failure.dart';
import '../../domain/usecases/location_usecases.dart';

part 'location_bloc.freezed.dart';
part 'location_event.dart';
part 'location_state.dart';

@injectable
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc(
    this._checkPermission,
    this._requestPermission,
    this._isServiceEnabled,
    this._getCurrentLocation,
    this._watchLocation,
    this._openAppSettings,
    this._openLocationSettings,
  ) : super(const LocationState()) {
    on<LocationStarted>((_, emit) => _evaluate(emit, prompt: false),
        transformer: droppable());
    on<LocationEnableRequested>((_, emit) => _evaluate(emit, prompt: true),
        transformer: droppable());
    on<LocationAppResumed>(_onResumed, transformer: droppable());
    on<LocationAppPaused>(_onPaused);
    on<LocationPromptDismissed>(
      (_, emit) => emit(state.copyWith(promptDismissed: true)),
    );
    on<LocationSettingsRequested>(_onSettingsRequested);
    on<_LocationFixReceived>(_onFixReceived);
    on<_LocationStreamFailed>(_onStreamFailed);
  }

  final CheckLocationPermission _checkPermission;
  final RequestLocationPermission _requestPermission;
  final IsLocationServiceEnabled _isServiceEnabled;
  final GetCurrentLocation _getCurrentLocation;
  final WatchLocation _watchLocation;
  final OpenAppSettings _openAppSettings;
  final OpenLocationSettings _openLocationSettings;

  static const _firstFixOptions =
      LocationRequestOptions(timeout: Duration(seconds: 15));
  static const _streamOptions = LocationRequestOptions(
    interval: Duration(seconds: 2),
    minDistanceMeters: 3,
  );

  StreamSubscription<Result<LocationFix>>? _subscription;
  bool _backgrounded = false;

  Future<void> _evaluate(
    Emitter<LocationState> emit, {
    required bool prompt,
  }) async {
    emit(
      state.copyWith(
        status: prompt ? LocationStatus.requesting : LocationStatus.checking,
        failure: null,
        promptDismissed: false,
      ),
    );

    final result = prompt
        ? await _requestPermission(const NoParams())
        : await _checkPermission(const NoParams());

    switch (result) {
      case Err(:final failure):
        _fail(emit, failure);
      case Ok(value: final permission):
        emit(state.copyWith(permission: permission));
        switch (permission) {
          case LocationPermissionStatus.granted ||
                LocationPermissionStatus.grantedApproximate:
            await _acquire(emit);
          case LocationPermissionStatus.denied:
            if (prompt) {
              _fail(emit, const LocationPermissionDenied());
            } else {
              emit(state.copyWith(status: LocationStatus.needsPermission));
            }
          case LocationPermissionStatus.deniedForever:
            _fail(emit, const LocationPermissionDeniedForever());
        }
    }
  }

  Future<void> _acquire(Emitter<LocationState> emit) async {
    final service = await _isServiceEnabled(const NoParams());
    if (service case Err(:final failure)) return _fail(emit, failure);
    if (service.valueOrNull != true) {
      return _fail(emit, const LocationServiceDisabled());
    }

    emit(state.copyWith(status: LocationStatus.acquiring));
    final result = await _getCurrentLocation(_firstFixOptions);
    switch (result) {
      case Ok(value: final fix):
        emit(state.copyWith(status: LocationStatus.ready, fix: fix));
        await _startStream();
      case Err(:final failure):
        _fail(emit, failure);
    }
  }

  Future<void> _startStream() async {
    await _stopStream();
    if (isClosed || _backgrounded) return;
    _subscription = _watchLocation(_streamOptions).listen((result) {
      if (isClosed) return;
      switch (result) {
        case Ok(value: final fix):
          add(_LocationFixReceived(fix));
        case Err(:final failure):
          add(_LocationStreamFailed(_asLocationFailure(failure)));
      }
    });
  }

  Future<void> _stopStream() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  void _onFixReceived(
    _LocationFixReceived event,
    Emitter<LocationState> emit,
  ) {
    emit(
      state.copyWith(
        status: LocationStatus.ready,
        fix: event.fix,
        failure: null,
      ),
    );
  }

  Future<void> _onStreamFailed(
    _LocationStreamFailed event,
    Emitter<LocationState> emit,
  ) async {
    await _stopStream();
    _fail(emit, event.failure);
  }

  Future<void> _onPaused(
    LocationAppPaused event,
    Emitter<LocationState> emit,
  ) async {
    _backgrounded = true;
    await _stopStream();
  }

  Future<void> _onResumed(
    LocationAppResumed event,
    Emitter<LocationState> emit,
  ) async {
    if (!_backgrounded) return;
    _backgrounded = false;
    if (state.isBusy) return;

    if (state.status == LocationStatus.ready) {
      await _startStream();
      return;
    }
    final recoverable = state.status == LocationStatus.needsPermission ||
        switch (state.failure) {
          LocationPermissionDenied() ||
          LocationPermissionDeniedForever() ||
          LocationServiceDisabled() =>
            true,
          _ => false,
        };
    if (recoverable) await _evaluate(emit, prompt: false);
  }

  Future<void> _onSettingsRequested(
    LocationSettingsRequested event,
    Emitter<LocationState> emit,
  ) async {
    switch (event.target) {
      case SettingsTarget.app:
        await _openAppSettings(const NoParams());
      case SettingsTarget.locationServices:
        await _openLocationSettings(const NoParams());
    }
  }

  void _fail(Emitter<LocationState> emit, Failure failure) {
    emit(
      state.copyWith(
        status: LocationStatus.failure,
        failure: _asLocationFailure(failure),
        promptDismissed: false,
      ),
    );
  }

  static LocationFailure _asLocationFailure(Failure f) =>
      f is LocationFailure ? f : LocationUnknownFailure(f.message);

  @override
  Future<void> close() async {
    await _stopStream();
    return super.close();
  }
}
