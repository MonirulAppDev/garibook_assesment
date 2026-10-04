import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/status_card.dart';
import '../../domain/failures/routing_failure.dart';
import '../bloc/routing_bloc.dart';

class RoutePanel extends StatelessWidget {
  const RoutePanel({this.showStartHint = true, super.key});

  final bool showStartHint;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutingBloc, RoutingState>(
      builder: (context, state) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _build(context, state) ?? const SizedBox.shrink(),
      ),
    );
  }

  Widget? _build(BuildContext context, RoutingState state) {
    final bloc = context.read<RoutingBloc>();

    if (state.isLoading) {
      return StatusCard(
        key: ValueKey('loading-${state.isSlow}'),
        isLoading: true,
        message: state.isSlow
            ? 'Still working… the routing server is slow.'
            : 'Finding the best route…',
      );
    }

    if (state.status == RouteStatus.failure && state.failure != null) {
      return StatusCard(
        key: const ValueKey('failure'),
        isError: true,
        icon: Icons.wrong_location_outlined,
        message: _failureMessage(state.failure!),
        actions: [
          TextButton(
            onPressed: () => bloc.add(const RouteCleared()),
            child: const Text('Clear'),
          ),
          FilledButton(
            onPressed: () => bloc.add(const RouteRetryRequested()),
            child: const Text('Retry'),
          ),
        ],
      );
    }

    if (state.route != null) {
      if (!(state.usesManualOrigin && state.deviceLocation != null)) {
        return null;
      }
      return Align(
        key: const ValueKey('useDevice'),
        alignment: Alignment.centerLeft,
        child: ActionChip(
          avatar: const Icon(Icons.my_location, size: 18),
          label: const Text('Route from my location'),
          onPressed: () => bloc.add(const RouteUseDeviceLocationRequested()),
        ),
      );
    }

    if (state.origin == null) {
      if (!showStartHint) return null;
      return const StatusCard(
        key: ValueKey('hintStart'),
        icon: Icons.touch_app_outlined,
        message: 'Long-press the map to set a start point.',
      );
    }

    return const StatusCard(
      key: ValueKey('hintDestination'),
      icon: Icons.touch_app_outlined,
      message: 'Long-press anywhere on the map to choose a destination.',
    );
  }

  static String _failureMessage(RoutingFailure failure) => switch (failure) {
        NoRouteFound() =>
          'No drivable route to that point. Try a spot on or near a road.',
        RoutingNetworkFailure() =>
          'No internet connection. Check your network and retry.',
        RoutingTimeout() => 'The routing server took too long to respond.',
        RoutingRateLimited() =>
          'Too many requests to the routing server. Wait a moment and retry.',
        RoutingServerFailure() => 'The routing server had a problem.',
        RoutingBadResponse() => 'Received an unexpected routing response.',
        RoutingCancelled() => 'Request cancelled.',
      };
}
