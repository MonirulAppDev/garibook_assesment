import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../core/config/flavor_config.dart';
import '../../core/di/injection.dart';
import '../../features/location/presentation/bloc/location_bloc.dart';
import '../../features/map/presentation/pages/map_page.dart';
import '../../features/navigation/presentation/cubit/navigation_cubit.dart';
import '../../features/routing/presentation/bloc/routing_bloc.dart';
import 'app_routes.dart';

/// Composition root for screens: resolves dependencies and hands them to
/// pages via constructors, so pages never call the service locator.
@lazySingleton
final class AppRouter {
  AppRouter(this._config);

  final FlavorConfig _config;

  late final GoRouter config = GoRouter(
    initialLocation: AppRoutes.mapPath,
    routes: [
      GoRoute(
        path: AppRoutes.mapPath,
        name: AppRoutes.mapName,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => getIt<LocationBloc>()..add(const LocationStarted()),
            ),
            BlocProvider(create: (_) => getIt<RoutingBloc>()),
            BlocProvider(create: (_) => getIt<NavigationCubit>()),
          ],
          child: MapPage(config: _config),
        ),
      ),
    ],
  );

  @disposeMethod
  void dispose() => config.dispose();
}
