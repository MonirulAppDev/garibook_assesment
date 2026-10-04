import '../entities/navigation_frame.dart';
import '../entities/navigation_status.dart';

abstract interface class NavigationEngine {
  NavigationStatus get status;
  NavigationFrame get frame;

  void start();
  void pause();
  void resume();
  void reset();
  void setSpeed(SpeedMultiplier speed);

  bool tick(Duration elapsed);
}
