import 'package:flutter/material.dart';

import '../core/config/flavor_config.dart';
import '../shared/theme/app_theme.dart';
import '../shared/widgets/flavor_banner.dart';
import 'router/app_router.dart';

class NavApp extends StatelessWidget {
  const NavApp({required this.config, required this.router, super.key});

  final FlavorConfig config;
  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router.config,
      builder: (context, child) => FlavorBanner(
        config: config,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
