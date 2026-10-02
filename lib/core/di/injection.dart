import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../config/flavor.dart';
import 'injection.config.dart';

/// Global service locator. Only the composition root (bootstrap, router)
/// resolves from it; everything else receives dependencies via constructors.
final GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
Future<void> configureDependencies(Flavor flavor) =>
    getIt.init(environment: flavor.name);

/// Injectable environments mirroring the build flavors.
abstract final class Env {
  static const dev = Environment('dev');
  static const prod = Environment('prod');
}
