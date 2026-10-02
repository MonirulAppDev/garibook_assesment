/// Enforces a minimum interval between operations (e.g. OSRM ~1 req/s).
///
/// [now] is injectable so behaviour is testable with a fake clock.
final class RateLimiter {
  RateLimiter(this.minInterval, {DateTime Function()? now})
      : _now = now ?? DateTime.now;

  final Duration minInterval;
  final DateTime Function() _now;
  DateTime? _last;

  /// How long the caller must wait before the next operation may run.
  Duration get waitTime {
    final last = _last;
    if (last == null) return Duration.zero;
    final elapsed = _now().difference(last);
    return elapsed >= minInterval ? Duration.zero : minInterval - elapsed;
  }

  void markRun() => _last = _now();
}
