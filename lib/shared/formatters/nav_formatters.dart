abstract final class NavFormatters {
  static String distance(double meters) {
    if (!meters.isFinite || meters <= 0) return '0 m';
    if (meters < 1000) return '${meters.round()} m';
    final km = meters / 1000;
    return '${km.toStringAsFixed(km < 10 ? 1 : 0)} km';
  }

  static String duration(Duration d) {
    if (d.isNegative) return '0 min';
    final minutes = (d.inSeconds / 60).ceil();
    if (minutes < 60) return '$minutes min';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m == 0 ? '$h h' : '$h h $m min';
  }

  static String durationSeconds(double seconds) => duration(
        Duration(seconds: seconds.isFinite && seconds > 0 ? seconds.round() : 0),
      );
}
