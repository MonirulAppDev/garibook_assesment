import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Reusable floating card for loading / info / error states over the map.
class StatusCard extends StatelessWidget {
  const StatusCard({
    required this.message,
    this.icon,
    this.isLoading = false,
    this.isError = false,
    this.actions = const [],
    super.key,
  });

  final String message;
  final IconData? icon;
  final bool isLoading;
  final bool isError;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final color = isError ? context.colors.error : context.colors.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                if (isLoading)
                  const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else if (icon != null)
                  Icon(icon, color: color),
                AppSpacing.gapMd,
                Expanded(
                  child: Text(message, style: context.textTheme.bodyMedium),
                ),
              ],
            ),
            if (actions.isNotEmpty) ...[
              AppSpacing.gapMd,
              Wrap(
                alignment: WrapAlignment.end,
                spacing: AppSpacing.sm,
                children: actions,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
