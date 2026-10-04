import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../config/flavor.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
Future<void> configureDependencies(Flavor flavor) =>
    getIt.init(environment: flavor.name);

abstract final class Env {
  static const dev = Environment('dev');
  static const prod = Environment('prod');
}
