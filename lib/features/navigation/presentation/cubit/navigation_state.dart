part of 'navigation_cubit.dart';

@freezed
abstract class NavigationState with _$NavigationState {
  const factory NavigationState({
    /// Null when there is no route loaded.
    NavigationFrame? frame,

    /// Camera follows the car until the user pans the map.
    @Default(true) bool following,
    @Default(SpeedMultiplier.x1) SpeedMultiplier speed,
  }) = _NavigationState;

  const NavigationState._();

  bool get hasRoute => frame != null;

  NavigationStatus get status => frame?.status ?? NavigationStatus.idle;

  bool get isPlaying => status == NavigationStatus.playing;

  /// Navigation has started and not been reset.
  bool get isActive =>
      status == NavigationStatus.playing || status == NavigationStatus.paused;
}
