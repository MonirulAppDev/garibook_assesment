part of 'navigation_cubit.dart';

enum DriveMode {
  /// Car animated along the route at a constant demo speed.
  simulation,

  /// Car follows the device's real GPS position.
  live,
}

@freezed
abstract class NavigationState with _$NavigationState {
  const factory NavigationState({
    /// Null when there is no route loaded.
    NavigationFrame? frame,
    @Default(DriveMode.simulation) DriveMode mode,

    /// Camera follows the car until the user moves the map.
    @Default(true) bool following,
    @Default(SpeedMultiplier.x1) SpeedMultiplier speed,

    /// Incremented each time live mode detects the device left the route;
    /// [rerouteFrom] is where to route from.
    @Default(0) int rerouteRequests,
    GeoPoint? rerouteFrom,
  }) = _NavigationState;

  const NavigationState._();

  bool get hasRoute => frame != null;

  NavigationStatus get status => frame?.status ?? NavigationStatus.idle;

  bool get isPlaying => status == NavigationStatus.playing;

  bool get isLive => mode == DriveMode.live;

  /// Navigation has started and not been reset or finished.
  bool get isActive =>
      status == NavigationStatus.playing || status == NavigationStatus.paused;
}
