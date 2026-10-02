import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../routing/domain/entities/nav_route.dart';
import '../../domain/engine/route_animator.dart';
import '../../domain/engine/route_geometry.dart';
import '../../domain/entities/navigation_frame.dart';
import '../../domain/entities/navigation_status.dart';

part 'navigation_cubit.freezed.dart';
part 'navigation_state.dart';

/// Thin adapter between the pure [RouteAnimator] and the UI.
///
/// Frame timing comes from outside via [tick] (see `NavigationTicker`), so
/// this cubit has no Flutter dependency and no timers of its own.
@injectable
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  RouteAnimator? _animator;
  bool _autoPaused = false;

  void loadRoute(NavRoute? route) {
    _autoPaused = false;
    if (route == null) {
      _animator = null;
      emit(NavigationState(speed: state.speed));
      return;
    }
    _animator = RouteAnimator(
      geometry: RouteGeometry.fromPoints(route.points),
      etaSpeedMps: route.averageSpeedMps,
      speed: state.speed,
    );
    _emitFrame(following: true);
  }

  void start() => _control((a) => a.start(), following: true);

  void pause() => _control((a) => a.pause());

  void resume() => _control((a) => a.resume());

  void reset() => _control((a) => a.reset(), following: true);

  void togglePlayPause() => switch (state.status) {
        NavigationStatus.playing => pause(),
        NavigationStatus.paused => resume(),
        NavigationStatus.idle || NavigationStatus.finished => start(),
      };

  void setSpeed(SpeedMultiplier speed) {
    _animator?.setSpeed(speed);
    if (_animator == null) {
      emit(state.copyWith(speed: speed));
    } else {
      _emitFrame(speed: speed);
    }
  }

  /// Called once per rendered frame while playing.
  void tick(Duration elapsed) {
    if (isClosed) return;
    if (_animator?.tick(elapsed) ?? false) _emitFrame();
  }

  void userMovedMap() {
    if (state.following && state.isActive) {
      emit(state.copyWith(following: false));
    }
  }

  void recenter() => emit(state.copyWith(following: true));

  /// App went to background: pause so nothing advances unseen.
  void appBackgrounded() {
    if (state.isPlaying) {
      pause(); // clears _autoPaused (user-control path), so set it after
      _autoPaused = true;
    }
  }

  /// Back in foreground: continue only if *we* paused it.
  void appForegrounded() {
    if (_autoPaused) resume(); // resume() clears the flag
  }

  void _control(void Function(RouteAnimator a) action, {bool? following}) {
    final animator = _animator;
    if (animator == null || isClosed) return;
    _autoPaused = false;
    action(animator);
    _emitFrame(following: following);
  }

  void _emitFrame({bool? following, SpeedMultiplier? speed}) {
    final animator = _animator;
    if (animator == null || isClosed) return;
    emit(
      state.copyWith(
        frame: animator.frame,
        following: following ?? state.following,
        speed: speed ?? state.speed,
      ),
    );
  }
}
