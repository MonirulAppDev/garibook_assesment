import '../../../../core/geo/geo_math.dart';
import '../../../../core/geo/geo_point.dart';
import '../entities/live_position.dart';
import '../entities/navigation_frame.dart';
import '../entities/navigation_status.dart';
import 'bearing_smoother.dart';
import 'navigation_engine.dart';
import 'route_geometry.dart';

final class LiveRouteTracker implements NavigationEngine {
  LiveRouteTracker({
    required this.geometry,
    required this.etaSpeedMps,
    this.snapThresholdMeters = 50,
    this.offRouteThresholdMeters = 50,
    this.offRouteConfirmations = 2,
    this.maxAccuracyForOffRouteMeters = 40,
    this.arrivalThresholdMeters = 20,
    this.glideDuration = const Duration(milliseconds: 1000),
  }) : _smoother = BearingSmoother(initial: geometry.initialBearing) {
    final start = geometry.start;
    if (start != null) {
      _from = _to = _Target(start, 0, geometry.initialBearing);
    }
  }

  final RouteGeometry geometry;
  final double etaSpeedMps;
  final double snapThresholdMeters;
  final double offRouteThresholdMeters;
  final int offRouteConfirmations;
  final double maxAccuracyForOffRouteMeters;
  final double arrivalThresholdMeters;
  final Duration glideDuration;

  final BearingSmoother _smoother;
  NavigationStatus _status = NavigationStatus.idle;
  _Target? _from;
  _Target? _to;
  double _t = 1;
  int _offRouteCount = 0;
  bool _arrived = false;
  GeoPoint? _lastRaw;
  double? _lastAlong = 0;

  @override
  NavigationStatus get status => _status;

  bool onPosition(LivePosition position) {
    if (_status != NavigationStatus.playing || !position.point.isValid) {
      return false;
    }
    final projection = geometry.project(position.point);
    if (projection == null) return false;

    final target = _targetFor(position, projection);
    final previousRaw = _lastRaw;
    _lastRaw = position.point;
    _from = _currentDisplay();
    _to = target;
    _t = previousRaw == null ? 1 : 0;

    if (target.along != null &&
        geometry.totalLength - target.along! <= arrivalThresholdMeters) {
      _arrived = true;
    }
    return _checkOffRoute(position, projection.offsetMeters);
  }

  void seed(LivePosition position) {
    final projection = geometry.project(position.point);
    if (projection == null) return;
    final target = _targetFor(position, projection);
    _from = _to = target;
    _t = 1;
    _lastRaw = position.point;
    _smoother.snapTo(target.bearing);
  }

  _Target _targetFor(LivePosition position, RouteProjection projection) {
    if (projection.offsetMeters <= snapThresholdMeters) {
      return _Target(projection.point, projection.distanceAlong, projection.bearing);
    }
    final previous = _lastRaw;
    final heading = position.headingDegrees ??
        (previous != null && GeoMath.distance(previous, position.point) > 1
            ? GeoMath.bearing(previous, position.point)
            : _smoother.value);
    return _Target(position.point, null, heading);
  }

  bool _checkOffRoute(LivePosition position, double offset) {
    final accuracy = position.accuracyMeters;
    final reliable = accuracy == null || accuracy <= maxAccuracyForOffRouteMeters;
    if (offset <= offRouteThresholdMeters) {
      _offRouteCount = 0;
    } else if (reliable) {
      _offRouteCount++;
    }
    if (_offRouteCount >= offRouteConfirmations) {
      _offRouteCount = 0;
      return true;
    }
    return false;
  }

  @override
  void start() {
    switch (_status) {
      case NavigationStatus.idle || NavigationStatus.finished:
        _arrived = false;
        _offRouteCount = 0;
        _status = NavigationStatus.playing;
      case NavigationStatus.paused:
        _status = NavigationStatus.playing;
      case NavigationStatus.playing:
        break;
    }
  }

  @override
  void pause() {
    if (_status == NavigationStatus.playing) _status = NavigationStatus.paused;
  }

  @override
  void resume() {
    if (_status == NavigationStatus.paused) _status = NavigationStatus.playing;
  }

  @override
  void reset() {
    _status = NavigationStatus.idle;
    _arrived = false;
    _offRouteCount = 0;
    _lastRaw = null;
    final start = geometry.start;
    if (start != null) {
      _from = _to = _Target(start, 0, geometry.initialBearing);
    }
    _t = 1;
    _lastAlong = 0;
    _smoother.snapTo(geometry.initialBearing);
  }

  @override
  void setSpeed(SpeedMultiplier speed) {}

  @override
  bool tick(Duration elapsed) {
    if (_status != NavigationStatus.playing || _to == null) return false;
    final dt = elapsed.inMicroseconds / Duration.microsecondsPerSecond;
    if (dt <= 0) return false;

    final glide = glideDuration.inMicroseconds / Duration.microsecondsPerSecond;
    final settledBefore = _t >= 1;
    _t = glide > 0 ? (_t + dt / glide).clamp(0.0, 1.0) : 1.0;

    final display = _currentDisplay();
    final before = _smoother.value;
    _smoother.step(display.bearing, dt);

    if (_arrived && _t >= 1) _status = NavigationStatus.finished;
    return !settledBefore || (_smoother.value - before).abs() > 1e-3 ||
        _status == NavigationStatus.finished;
  }

  _Target _currentDisplay() {
    final from = _from;
    final to = _to;
    if (from == null || to == null) {
      return _Target(geometry.start ?? const GeoPoint(latitude: 0, longitude: 0), 0, 0);
    }
    if (_t >= 1) return to;
    final fromAlong = from.along;
    final toAlong = to.along;
    if (fromAlong != null && toAlong != null) {
      final along = fromAlong + (toAlong - fromAlong) * _t;
      final pos = geometry.positionAt(along);
      return _Target(pos.point, along, pos.bearing);
    }
    return _Target(GeoMath.lerp(from.point, to.point, _t), null, to.bearing);
  }

  @override
  NavigationFrame get frame {
    final display = _currentDisplay();
    final along = display.along ?? _lastAlong ?? 0;
    _lastAlong = along;
    final remaining = (geometry.totalLength - along).clamp(0.0, double.infinity);
    final seconds = etaSpeedMps > 0 ? remaining / etaSpeedMps : 0.0;
    return NavigationFrame(
      position: display.point,
      bearingDegrees: _smoother.value,
      travelledMeters: along,
      remainingMeters: remaining,
      remainingTime: Duration(
        milliseconds: seconds.isFinite ? (seconds * 1000).round() : 0,
      ),
      status: _status,
      speed: SpeedMultiplier.x1,
    );
  }
}

final class _Target {
  const _Target(this.point, this.along, this.bearing);

  final GeoPoint point;
  final double? along;
  final double bearing;
}
