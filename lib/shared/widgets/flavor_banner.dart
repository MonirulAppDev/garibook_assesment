import 'package:flutter/material.dart';

import '../../core/config/flavor_config.dart';
import '../theme/app_colors.dart';

/// Corner ribbon that makes non-production builds impossible to miss.
class FlavorBanner extends StatelessWidget {
  const FlavorBanner({required this.config, required this.child, super.key});

  final FlavorConfig config;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!config.showDevBadge) return child;
    return Banner(
      message: config.flavor.name.toUpperCase(),
      location: BannerLocation.topStart,
      color: AppColors.devBadge,
      child: child,
    );
  }
}
