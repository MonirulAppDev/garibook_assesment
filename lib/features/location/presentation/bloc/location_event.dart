part of 'location_bloc.dart';

sealed class LocationEvent {
  const LocationEvent();
}

/// Screen opened: check permission silently (never prompts).
final class LocationStarted extends LocationEvent {
  const LocationStarted();
}

/// User tapped "Enable location" / "Try again": may show the OS dialog.
final class LocationEnableRequested extends LocationEvent {
  const LocationEnableRequested();
}

/// User closed the explanation / error card.
final class LocationPromptDismissed extends LocationEvent {
  const LocationPromptDismissed();
}

enum SettingsTarget { app, locationServices }

final class LocationSettingsRequested extends LocationEvent {
  const LocationSettingsRequested(this.target);
  final SettingsTarget target;
}

final class LocationAppPaused extends LocationEvent {
  const LocationAppPaused();
}

final class LocationAppResumed extends LocationEvent {
  const LocationAppResumed();
}

final class _LocationFixReceived extends LocationEvent {
  const _LocationFixReceived(this.fix);
  final LocationFix fix;
}

final class _LocationStreamFailed extends LocationEvent {
  const _LocationStreamFailed(this.failure);
  final LocationFailure failure;
}
