import '../../../../core/geo/geo_math.dart';

/// Eases the displayed heading toward a target heading, always turning the
/// short way round (359° → 1° rotates +2°, not −358°), at a bounded rate
/// that is independent of frame rate.
final class BearingSmoother {
  BearingSmoother({double initial = 0, this.maxDegreesPerSecond = 360})
      : _current = GeoMath.normalizeDegrees(initial);

  final double maxDegreesPerSecond;
  double _current;

  double get value => _current;

  void snapTo(double bearing) => _current = GeoMath.normalizeDegrees(bearing);

  /// Advances toward [target] by at most `rate * dtSeconds * rateScale`.
  double step(double target, double dtSeconds, {double rateScale = 1}) {
    if (!dtSeconds.isFinite || dtSeconds <= 0) return _current;
    final delta = GeoMath.shortestAngleDelta(_current, target);
    final maxStep = maxDegreesPerSecond * rateScale * dtSeconds;
    _current = GeoMath.normalizeDegrees(
      delta.abs() <= maxStep ? _current + delta : _current + maxStep * delta.sign,
    );
    return _current;
  }
}
