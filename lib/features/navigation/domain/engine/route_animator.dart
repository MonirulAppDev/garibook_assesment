import '../entities/navigation_frame.dart';
import '../entities/navigation_status.dart';
import 'bearing_smoother.dart';
import 'route_geometry.dart';

/// Pure-Dart car simulation along a [RouteGeometry].
///
/// Driven externally by [tick] (a Flutter Ticker in the app, plain calls in
/// tests), so it is fully testable without a map widget or real time.
final class RouteAnimator {
  RouteAnimator({
    required this.geometry,
    required this.etaSpeedMps,
    double? baseSpeedMps,
    this.maxStep = const Duration(milliseconds: 100),
    this._speed = SpeedMultiplier.x1,
  })  : baseSpeedMps = baseSpeedMps ?? simulationSpeedFor(geometry.totalLength),
        _smoother = BearingSmoother(initial: geometry.initialBearing);

  /// Default demo speed: a whole route takes about a minute at 1x, clamped
  /// to a believable range. Speed is constant along the route.
  static double simulationSpeedFor(double lengthMeters) =>
      lengthMeters.isFinite ? (lengthMeters / 60).clamp(15.0, 250.0) : 15.0;

  final RouteGeometry geometry;

  /// Real-world average speed (from the router) used for the live ETA, so
  /// remaining time reflects driving time rather than the demo speed.
  final double etaSpeedMps;

  final double baseSpeedMps;

  /// Upper bound for one tick. Prevents teleporting after a frame hitch or
  /// returning from background (large elapsed gaps).
  final Duration maxStep;

  final BearingSmoother _smoother;
  NavigationStatus _status = NavigationStatus.idle;
  SpeedMultiplier _speed;
  double _travelled = 0;

  NavigationStatus get status => _status;
  SpeedMultiplier get speed => _speed;
  double get travelled => _travelled;
  double get remaining =>
      (geometry.totalLength - _travelled).clamp(0.0, double.infinity);

  // region controls (invalid transitions are no-ops)

  void start() {
    if (geometry.isDegenerate) {
      _travelled = geometry.totalLength;
      _status = NavigationStatus.finished;
      return;
    }
    switch (_status) {
      case NavigationStatus.idle:
        _status = NavigationStatus.playing;
      case NavigationStatus.finished:
        _rewind();
        _status = NavigationStatus.playing;
      case NavigationStatus.playing || NavigationStatus.paused:
        break;
    }
  }

  void pause() {
    if (_status == NavigationStatus.playing) _status = NavigationStatus.paused;
  }

  void resume() {
    if (_status == NavigationStatus.paused) _status = NavigationStatus.playing;
  }

  void reset() {
    _rewind();
    _status = NavigationStatus.idle;
  }

  void setSpeed(SpeedMultiplier speed) => _speed = speed;

  // endregion

  /// Advances the simulation by [elapsed]. Returns true if the frame changed.
  bool tick(Duration elapsed) {
    if (_status != NavigationStatus.playing) return false;
    final clamped = elapsed > maxStep ? maxStep : elapsed;
    final dt = clamped.inMicroseconds / Duration.microsecondsPerSecond;
    if (dt <= 0) return false;

    _travelled += baseSpeedMps * _speed.factor * dt;
    if (_travelled >= geometry.totalLength) {
      _travelled = geometry.totalLength;
      _status = NavigationStatus.finished;
    }
    final target = geometry.positionAt(_travelled).bearing;
    // Turn faster at higher playback speeds so heading keeps up with corners.
    _smoother.step(target, dt, rateScale: _speed.factor);
    return true;
  }

  NavigationFrame get frame {
    final position = geometry.positionAt(_travelled);
    final remainingMeters = remaining;
    final seconds = etaSpeedMps > 0 ? remainingMeters / etaSpeedMps : 0.0;
    return NavigationFrame(
      position: position.point,
      bearingDegrees: _smoother.value,
      travelledMeters: _travelled,
      remainingMeters: remainingMeters,
      remainingTime: Duration(
        milliseconds: seconds.isFinite ? (seconds * 1000).round() : 0,
      ),
      status: _status,
      speed: _speed,
    );
  }

  void _rewind() {
    _travelled = 0;
    _smoother.snapTo(geometry.initialBearing);
  }
}
