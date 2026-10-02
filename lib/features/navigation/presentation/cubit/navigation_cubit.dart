import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/geo/geo_point.dart';
import '../../../routing/domain/entities/nav_route.dart';
import '../../domain/engine/live_route_tracker.dart';
import '../../domain/engine/navigation_engine.dart';
import '../../domain/engine/route_animator.dart';
import '../../domain/engine/route_geometry.dart';
import '../../domain/entities/live_position.dart';
import '../../domain/entities/navigation_frame.dart';
import '../../domain/entities/navigation_status.dart';

part 'navigation_cubit.freezed.dart';
part 'navigation_state.dart';

/// Thin adapter between a [NavigationEngine] and the UI.
///
/// Frame timing comes from outside via [tick] (see `NavigationTicker`), so
/// this cubit has no Flutter dependency and no timers of its own.
@injectable
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit({
    @ignoreParam this._rerouteCooldown = const Duration(seconds: 15),
    @ignoreParam DateTime Function()? now,
  })  : _now = now ?? DateTime.now,
        super(const NavigationState());

  final Duration _rerouteCooldown;
  final DateTime Function() _now;

  NavRoute? _route;
  NavigationEngine? _engine;
  LivePosition? _lastLive;
  DateTime? _lastRerouteAt;
  bool _autoPaused = false;

  // region route & mode

  /// Loads (or clears) the route. In live mode an active session keeps
  /// tracking on the new route, which is what a re-route needs.
  void loadRoute(NavRoute? route) {
    final continueLive = state.isLive && state.isActive;
    _route = route;
    _autoPaused = false;
    if (route == null) {
      _engine = null;
      emit(NavigationState(mode: state.mode, speed: state.speed));
      return;
    }
    _engine = _createEngine(route);
    if (continueLive) _startEngine();
    _emitFrame(following: continueLive ? state.following : true);
  }

  void setMode(DriveMode mode) {
    if (mode == state.mode) return;
    _autoPaused = false;
    final route = _route;
    if (route == null) {
      emit(state.copyWith(mode: mode));
      return;
    }
    emit(state.copyWith(mode: mode));
    _engine = _createEngine(route);
    _emitFrame(following: true);
  }

  NavigationEngine _createEngine(NavRoute route) {
    final geometry = RouteGeometry.fromPoints(route.points);
    return switch (state.mode) {
      DriveMode.simulation => RouteAnimator(
          geometry: geometry,
          etaSpeedMps: route.averageSpeedMps,
          speed: state.speed,
        ),
      DriveMode.live => LiveRouteTracker(
          geometry: geometry,
          etaSpeedMps: route.averageSpeedMps,
        ),
    };
  }

  // endregion

  // region controls

  void start() => _control((_) => _startEngine(), following: true);

  void pause() => _control((e) => e.pause());

  void resume() => _control((e) => e.resume());

  void reset() => _control((e) => e.reset(), following: true);

  void togglePlayPause() => switch (state.status) {
        NavigationStatus.playing => pause(),
        NavigationStatus.paused => resume(),
        NavigationStatus.idle || NavigationStatus.finished => start(),
      };

  void setSpeed(SpeedMultiplier speed) {
    _engine?.setSpeed(speed);
    if (_engine == null) {
      emit(state.copyWith(speed: speed));
    } else {
      _emitFrame(speed: speed);
    }
  }

  void _startEngine() {
    final engine = _engine;
    if (engine == null) return;
    engine.start();
    final last = _lastLive;
    if (engine is LiveRouteTracker && last != null) engine.seed(last);
  }

  // endregion

  // region live GPS

  /// Latest device position. Always remembered (to seed live mode); only
  /// moves the car while a live session is playing.
  void onLivePosition(LivePosition position) {
    if (isClosed) return;
    _lastLive = position;
    final engine = _engine;
    if (engine is! LiveRouteTracker) return;

    final offRoute = engine.onPosition(position);
    if (offRoute && _rerouteAllowed()) {
      _lastRerouteAt = _now();
      emit(
        state.copyWith(
          rerouteRequests: state.rerouteRequests + 1,
          rerouteFrom: position.point,
        ),
      );
    }
  }

  bool _rerouteAllowed() {
    final last = _lastRerouteAt;
    return last == null || _now().difference(last) >= _rerouteCooldown;
  }

  // endregion

  /// Called once per rendered frame while playing.
  void tick(Duration elapsed) {
    if (isClosed) return;
    if (_engine?.tick(elapsed) ?? false) _emitFrame();
  }

  // region camera & lifecycle

  void userMovedMap() {
    if (state.following && state.isActive) {
      emit(state.copyWith(following: false));
    }
  }

  void recenter() => emit(state.copyWith(following: true));

  /// App went to background: pause the simulation so nothing advances
  /// unseen. Live mode keeps its state (no fixes arrive in background).
  void appBackgrounded() {
    if (state.isPlaying && !state.isLive) {
      pause(); // clears _autoPaused (user-control path), so set it after
      _autoPaused = true;
    }
  }

  /// Back in foreground: continue only if *we* paused it.
  void appForegrounded() {
    if (_autoPaused) resume(); // resume() clears the flag
  }

  // endregion

  void _control(void Function(NavigationEngine e) action, {bool? following}) {
    final engine = _engine;
    if (engine == null || isClosed) return;
    _autoPaused = false;
    action(engine);
    _emitFrame(following: following);
  }

  void _emitFrame({bool? following, SpeedMultiplier? speed}) {
    final engine = _engine;
    if (engine == null || isClosed) return;
    emit(
      state.copyWith(
        frame: engine.frame,
        following: following ?? state.following,
        speed: speed ?? state.speed,
      ),
    );
  }
}
