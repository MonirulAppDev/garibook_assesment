import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/formatters/nav_formatters.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../domain/entities/navigation_status.dart';
import '../cubit/navigation_cubit.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({
    required this.onClose,
    this.liveAvailable = false,
    super.key,
  });

  final VoidCallback onClose;

  final bool liveAvailable;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        final frame = state.frame;
        if (frame == null) return const SizedBox.shrink();
        final cubit = context.read<NavigationCubit>();
        final finished = frame.status == NavigationStatus.finished;

        return Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.sm,
              AppSpacing.md,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: finished
                          ? Text(
                              'You have arrived',
                              style: context.textTheme.titleLarge,
                            )
                          : Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: NavFormatters.duration(
                                      frame.remainingTime,
                                    ),
                                    style: context.textTheme.titleLarge,
                                  ),
                                  TextSpan(
                                    text:
                                        '  ·  ${NavFormatters.distance(frame.remainingMeters)}',
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(
                                      color: context.colors.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    IconButton(
                      tooltip: 'Clear route',
                      onPressed: onClose,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                AppSpacing.gapXs,
                ClipRRect(
                  borderRadius: const BorderRadius.all(AppRadius.sm),
                  child: LinearProgressIndicator(
                    value: frame.progress,
                    minHeight: 6,
                  ),
                ),
                AppSpacing.gapMd,
                Row(
                  children: [
                    FilledButton.icon(
                      onPressed: cubit.togglePlayPause,
                      icon: Icon(_playIcon(frame.status)),
                      label: Text(_playLabel(frame.status)),
                    ),
                    AppSpacing.gapSm,
                    IconButton.outlined(
                      tooltip: 'Reset',
                      onPressed: frame.status == NavigationStatus.idle
                          ? null
                          : cubit.reset,
                      icon: const Icon(Icons.replay),
                    ),
                    const Spacer(),
                    if (state.isLive)
                      Text(
                        'Following GPS',
                        style: context.textTheme.labelLarge?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      )
                    else
                      SegmentedButton<SpeedMultiplier>(
                        showSelectedIcon: false,
                        style: const ButtonStyle(
                          visualDensity: VisualDensity.compact,
                        ),
                        segments: [
                          for (final s in SpeedMultiplier.values)
                            ButtonSegment(value: s, label: Text(s.label)),
                        ],
                        selected: {state.speed},
                        onSelectionChanged: (s) => cubit.setSpeed(s.first),
                      ),
                  ],
                ),
                AppSpacing.gapSm,
                SegmentedButton<DriveMode>(
                  showSelectedIcon: false,
                  style: const ButtonStyle(
                    visualDensity: VisualDensity.compact,
                  ),
                  segments: [
                    const ButtonSegment(
                      value: DriveMode.simulation,
                      icon: Icon(Icons.smart_display_outlined, size: 18),
                      label: Text('Simulate'),
                    ),
                    ButtonSegment(
                      value: DriveMode.live,
                      enabled: liveAvailable,
                      icon: const Icon(Icons.gps_fixed, size: 18),
                      label: const Text('Live GPS'),
                    ),
                  ],
                  selected: {state.mode},
                  onSelectionChanged: (m) => cubit.setMode(m.first),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static IconData _playIcon(NavigationStatus s) => switch (s) {
        NavigationStatus.playing => Icons.pause,
        NavigationStatus.finished => Icons.replay,
        NavigationStatus.idle || NavigationStatus.paused => Icons.play_arrow,
      };

  static String _playLabel(NavigationStatus s) => switch (s) {
        NavigationStatus.idle => 'Start',
        NavigationStatus.playing => 'Pause',
        NavigationStatus.paused => 'Resume',
        NavigationStatus.finished => 'Restart',
      };
}
