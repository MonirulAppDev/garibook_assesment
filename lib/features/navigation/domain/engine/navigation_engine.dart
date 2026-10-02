import '../entities/navigation_frame.dart';
import '../entities/navigation_status.dart';

/// Common contract for anything that moves the car along a route:
/// the simulated [RouteAnimator] and the GPS-driven [LiveRouteTracker].
///
/// The presentation layer drives every engine the same way (controls +
/// per-frame [tick]), so adding a new mode does not touch the cubit's
/// control flow (open/closed).
abstract interface class NavigationEngine {
  NavigationStatus get status;
  NavigationFrame get frame;

  void start();
  void pause();
  void resume();
  void reset();
  void setSpeed(SpeedMultiplier speed);

  /// Advances by [elapsed]; returns true if [frame] changed.
  bool tick(Duration elapsed);
}
