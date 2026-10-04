final class RateLimiter {
  RateLimiter(this.minInterval, {DateTime Function()? now})
      : _now = now ?? DateTime.now;

  final Duration minInterval;
  final DateTime Function() _now;
  DateTime? _last;

  Duration get waitTime {
    final last = _last;
    if (last == null) return Duration.zero;
    final elapsed = _now().difference(last);
    return elapsed >= minInterval ? Duration.zero : minInterval - elapsed;
  }

  void markRun() => _last = _now();
}
