import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/status_card.dart';
import '../../domain/failures/location_failure.dart';
import '../bloc/location_bloc.dart';

/// Explains and resolves every location state (permission, services,
/// first fix). Renders nothing when location is fine or the card was
/// dismissed.
class LocationStatusPanel extends StatelessWidget {
  const LocationStatusPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        final card = _buildCard(context, state);
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: card ?? const SizedBox.shrink(),
        );
      },
    );
  }

  Widget? _buildCard(BuildContext context, LocationState state) {
    final bloc = context.read<LocationBloc>();
    void add(LocationEvent e) => bloc.add(e);

    final dismiss = TextButton(
      onPressed: () => add(const LocationPromptDismissed()),
      child: const Text('Not now'),
    );

    if (state.promptDismissed) return null;

    switch (state.status) {
      case LocationStatus.initial ||
            LocationStatus.checking ||
            LocationStatus.requesting ||
            LocationStatus.ready:
        return null;

      case LocationStatus.acquiring:
        return const StatusCard(
          key: ValueKey('acquiring'),
          isLoading: true,
          message: 'Finding your location…',
        );

      case LocationStatus.needsPermission:
        return StatusCard(
          key: const ValueKey('needsPermission'),
          icon: Icons.my_location,
          message: 'Share your location to plan a route from where you are. '
              'You can also long-press the map to pick a start point.',
          actions: [
            dismiss,
            FilledButton(
              onPressed: () => add(const LocationEnableRequested()),
              child: const Text('Enable location'),
            ),
          ],
        );

      case LocationStatus.failure:
        final failure = state.failure ?? const LocationUnknownFailure('');
        return switch (failure) {
          LocationPermissionDenied() => StatusCard(
              key: const ValueKey('denied'),
              isError: true,
              icon: Icons.location_disabled,
              message: 'Location permission was denied. '
                  'Long-press the map to set a start point instead.',
              actions: [
                dismiss,
                FilledButton(
                  onPressed: () => add(const LocationEnableRequested()),
                  child: const Text('Try again'),
                ),
              ],
            ),
          LocationPermissionDeniedForever() => StatusCard(
              key: const ValueKey('deniedForever'),
              isError: true,
              icon: Icons.block,
              message: 'Location is blocked for this app. '
                  'Allow it in Settings, or long-press to set a start point.',
              actions: [
                dismiss,
                FilledButton(
                  onPressed: () =>
                      add(const LocationSettingsRequested(SettingsTarget.app)),
                  child: const Text('Open settings'),
                ),
              ],
            ),
          LocationServiceDisabled() => StatusCard(
              key: const ValueKey('servicesOff'),
              isError: true,
              icon: Icons.location_off,
              message: 'Location services are turned off on this device.',
              actions: [
                dismiss,
                FilledButton(
                  onPressed: () => add(
                    const LocationSettingsRequested(
                      SettingsTarget.locationServices,
                    ),
                  ),
                  child: const Text('Turn on'),
                ),
              ],
            ),
          LocationTimeout() => StatusCard(
              key: const ValueKey('timeout'),
              isError: true,
              icon: Icons.gps_not_fixed,
              message: "Couldn't get a GPS fix. Move to open sky and retry, "
                  'or long-press to set a start point.',
              actions: [
                dismiss,
                FilledButton(
                  onPressed: () => add(const LocationEnableRequested()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          LocationNotSupported() => StatusCard(
              key: const ValueKey('notSupported'),
              icon: Icons.info_outline,
              message: 'Device location is not supported on this platform. '
                  'Long-press the map to set a start point.',
              actions: [dismiss],
            ),
          LocationUnavailable() || LocationUnknownFailure() => StatusCard(
              key: const ValueKey('unavailable'),
              isError: true,
              icon: Icons.error_outline,
              message: 'Location is unavailable right now.',
              actions: [
                dismiss,
                FilledButton(
                  onPressed: () => add(const LocationEnableRequested()),
                  child: const Text('Retry'),
                ),
              ],
            ),
        };
    }
  }
}
