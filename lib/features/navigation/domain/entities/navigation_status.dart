enum NavigationStatus { idle, playing, paused, finished }

enum SpeedMultiplier {
  x1(1),
  x2(2),
  x5(5);

  const SpeedMultiplier(this.factor);
  final double factor;

  String get label => '${factor.toInt()}x';
}
