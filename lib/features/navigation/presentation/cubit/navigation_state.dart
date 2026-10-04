part of 'navigation_cubit.dart';

enum DriveMode {
  simulation,

  live,
}

@freezed
abstract class NavigationState with _$NavigationState {
  const factory NavigationState({
    NavigationFrame? frame,
    @Default(DriveMode.simulation) DriveMode mode,

    @Default(true) bool following,
    @Default(SpeedMultiplier.x1) SpeedMultiplier speed,

    @Default(0) int rerouteRequests,
    GeoPoint? rerouteFrom,
  }) = _NavigationState;

  const NavigationState._();

  bool get hasRoute => frame != null;

  NavigationStatus get status => frame?.status ?? NavigationStatus.idle;

  bool get isPlaying => status == NavigationStatus.playing;

  bool get isLive => mode == DriveMode.live;

  bool get isActive =>
      status == NavigationStatus.playing || status == NavigationStatus.paused;
}
