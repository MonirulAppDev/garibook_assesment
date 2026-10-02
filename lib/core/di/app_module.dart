import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../config/flavor_config.dart';
import '../config/flavor_config_loader.dart';

/// Third-party / async registrations that can't be annotated directly.
@module
abstract class AppModule {
  @preResolve
  @singleton
  Future<FlavorConfig> get flavorConfig =>
      FlavorConfigLoader.load(FlavorConfigLoader.resolveFlavor());

  @lazySingleton
  Logger logger(FlavorConfig config) => Logger(
        level: config.isDev ? Level.debug : Level.warning,
        printer: PrettyPrinter(methodCount: 0),
      );
}
