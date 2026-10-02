import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/geo/geo_point.dart';
import '../../../../core/result/result.dart';
import '../../../../core/utils/rate_limiter.dart';
import '../../domain/entities/nav_route.dart';
import '../../domain/failures/routing_failure.dart';
import '../../domain/usecases/get_driving_route.dart';

part 'routing_bloc.freezed.dart';
part 'routing_event.dart';
part 'routing_state.dart';

/// Route selection and fetching.
///
/// Protecting the shared OSRM demo server and the UI from races:
/// 1. **Debounce** – rapid long-presses collapse into one request.
/// 2. **Rate limit** – at least [minRequestInterval] between requests.
/// 3. **Restartable** – a new fetch cancels the pending handler.
/// 4. **Request id** – a response that isn't for the latest request is
///    dropped (the data source also cancels the superseded HTTP call).
@injectable
class RoutingBloc extends Bloc<RoutingEvent, RoutingState> {
  RoutingBloc(
    this._getDrivingRoute, {
    @ignoreParam this._debounce = const Duration(milliseconds: 400),
    @ignoreParam Duration minRequestInterval = const Duration(seconds: 1),
    @ignoreParam this._slowThreshold = const Duration(seconds: 3),
    @ignoreParam DateTime Function()? now,
  })  : _rateLimiter = RateLimiter(minRequestInterval, now: now),
        super(const RoutingState()) {
    on<RouteMapLongPressed>(_onLongPressed);
    on<RouteDeviceLocationChanged>(_onDeviceLocationChanged);
    on<RouteUseDeviceLocationRequested>(_onUseDeviceLocation);
    on<RouteRetryRequested>(_onRetry);
    on<RouteCleared>(_onCleared);
    on<_RouteFetchRequested>(_onFetch, transformer: restartable());
    on<_RouteSlowDetected>(_onSlow);
  }

  final GetDrivingRoute _getDrivingRoute;
  final Duration _debounce;
  final Duration _slowThreshold;
  final RateLimiter _rateLimiter;

  int _requestId = 0;
  Timer? _slowTimer;

  void _onLongPressed(RouteMapLongPressed event, Emitter<RoutingState> emit) {
    if (!event.point.isValid) return;

    if (state.origin == null) {
      // No usable device location: first long-press picks the start.
      emit(
        state.copyWith(
          manualOrigin: event.point,
          destination: null,
          route: null,
          failure: null,
          status: RouteStatus.idle,
        ),
      );
      return;
    }
    emit(state.copyWith(destination: event.point));
    _requestFetch(emit);
  }

  void _onDeviceLocationChanged(
    RouteDeviceLocationChanged event,
    Emitter<RoutingState> emit,
  ) {
    // Does not re-fetch: the route is planned from where the user was.
    emit(state.copyWith(deviceLocation: event.location));
  }

  void _onUseDeviceLocation(
    RouteUseDeviceLocationRequested event,
    Emitter<RoutingState> emit,
  ) {
    if (state.deviceLocation == null) return;
    emit(state.copyWith(manualOrigin: null));
    if (state.destination != null) _requestFetch(emit);
  }

  void _onRetry(RouteRetryRequested event, Emitter<RoutingState> emit) {
    if (state.origin != null && state.destination != null) _requestFetch(emit);
  }

  void _onCleared(RouteCleared event, Emitter<RoutingState> emit) {
    _invalidateInFlight();
    emit(RoutingState(deviceLocation: state.deviceLocation));
  }

  void _requestFetch(Emitter<RoutingState> emit) {
    emit(
      state.copyWith(
        status: RouteStatus.loading,
        isSlow: false,
        failure: null,
      ),
    );
    add(const _RouteFetchRequested());
  }

  Future<void> _onFetch(
    _RouteFetchRequested event,
    Emitter<RoutingState> emit,
  ) async {
    final id = ++_requestId;
    _slowTimer?.cancel();

    // Debounce: if another fetch arrives meanwhile, restartable() cancels
    // this handler and emit.isDone becomes true.
    await Future<void>.delayed(_debounce);
    if (emit.isDone) return;

    final wait = _rateLimiter.waitTime;
    if (wait > Duration.zero) {
      await Future<void>.delayed(wait);
      if (emit.isDone) return;
    }

    final origin = state.origin;
    final destination = state.destination;
    if (origin == null || destination == null) return;

    _rateLimiter.markRun();
    _slowTimer = Timer(_slowThreshold, () {
      if (!isClosed) add(_RouteSlowDetected(id));
    });

    final result = await _getDrivingRoute(
      RouteParams(from: origin, to: destination),
    );
    if (id == _requestId) _slowTimer?.cancel();
    if (emit.isDone || id != _requestId) return; // stale response

    switch (result) {
      case Ok(value: final route):
        emit(
          state.copyWith(
            status: RouteStatus.success,
            route: route,
            isSlow: false,
            failure: null,
          ),
        );
      case Err(failure: RoutingCancelled()):
        return; // superseded; the newer request will report
      case Err(:final failure):
        emit(
          state.copyWith(
            status: RouteStatus.failure,
            isSlow: false,
            failure: failure is RoutingFailure
                ? failure
                : RoutingBadResponse(failure.message),
          ),
        );
    }
  }

  void _onSlow(_RouteSlowDetected event, Emitter<RoutingState> emit) {
    if (event.requestId == _requestId && state.isLoading) {
      emit(state.copyWith(isSlow: true));
    }
  }

  void _invalidateInFlight() {
    _requestId++;
    _slowTimer?.cancel();
  }

  @override
  Future<void> close() {
    _invalidateInFlight();
    return super.close();
  }
}
