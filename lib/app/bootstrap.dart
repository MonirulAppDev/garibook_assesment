import 'dart:async';

import 'package:flutter/material.dart';

import '../core/config/flavor_config.dart';
import '../core/config/flavor_config_loader.dart';
import '../core/di/injection.dart';
import '../core/logging/app_logger.dart';
import 'app.dart';
import 'router/app_router.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies(FlavorConfigLoader.resolveFlavor());
  final logger = getIt<AppLogger>();

  FlutterError.onError = (details) {
    logger.error('Flutter error', details.exception, details.stack);
    FlutterError.presentError(details);
  };
  WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
    logger.error('Uncaught error', error, stack);
    return true;
  };

  runApp(
    NavApp(
      config: getIt<FlavorConfig>(),
      router: getIt<AppRouter>(),
    ),
  );
}
