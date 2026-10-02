// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import '../../app/router/app_router.dart' as _i180;
import '../../features/location/data/datasources/location_platform_data_source.dart'
    as _i936;
import '../../features/location/data/repositories/location_repository_impl.dart'
    as _i115;
import '../../features/location/domain/repositories/location_repository.dart'
    as _i332;
import '../../features/location/domain/usecases/location_usecases.dart' as _i90;
import '../../features/location/presentation/bloc/location_bloc.dart' as _i845;
import '../../features/navigation/presentation/cubit/navigation_cubit.dart'
    as _i561;
import '../../features/routing/data/datasources/osrm_api.dart' as _i37;
import '../../features/routing/data/datasources/routing_api_module.dart'
    as _i720;
import '../../features/routing/data/datasources/routing_remote_data_source.dart'
    as _i577;
import '../../features/routing/data/mappers/polyline_decoder.dart' as _i226;
import '../../features/routing/data/repositories/routing_repository_impl.dart'
    as _i591;
import '../../features/routing/domain/repositories/routing_repository.dart'
    as _i1054;
import '../../features/routing/domain/usecases/get_driving_route.dart' as _i333;
import '../../features/routing/presentation/bloc/routing_bloc.dart' as _i153;
import '../config/flavor_config.dart' as _i636;
import '../logging/app_logger.dart' as _i354;
import '../logging/logger_app_logger.dart' as _i199;
import '../network/network_module.dart' as _i200;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final networkModule = _$NetworkModule();
    final routingApiModule = _$RoutingApiModule();
    gh.factory<_i561.NavigationCubit>(() => _i561.NavigationCubit());
    await gh.singletonAsync<_i636.FlavorConfig>(
      () => appModule.flavorConfig,
      preResolve: true,
    );
    gh.lazySingleton<_i226.PolylineDecoder>(
      () => const _i226.PolylineDecoder(),
    );
    gh.lazySingleton<_i936.LocationPlatformDataSource>(
      () => _i936.MethodChannelLocationDataSource(),
    );
    gh.lazySingleton<_i974.Logger>(
      () => appModule.logger(gh<_i636.FlavorConfig>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.routingDio(gh<_i636.FlavorConfig>()),
      instanceName: 'routingDio',
    );
    gh.lazySingleton<_i332.LocationRepository>(
      () =>
          _i115.LocationRepositoryImpl(gh<_i936.LocationPlatformDataSource>()),
    );
    gh.lazySingleton<_i37.OsrmApi>(
      () => routingApiModule.osrmApi(gh<_i361.Dio>(instanceName: 'routingDio')),
    );
    gh.lazySingleton<_i354.AppLogger>(
      () => _i199.LoggerAppLogger(gh<_i974.Logger>()),
    );
    gh.lazySingleton<_i180.AppRouter>(
      () => _i180.AppRouter(gh<_i636.FlavorConfig>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i90.CheckLocationPermission>(
      () => _i90.CheckLocationPermission(gh<_i332.LocationRepository>()),
    );
    gh.factory<_i90.RequestLocationPermission>(
      () => _i90.RequestLocationPermission(gh<_i332.LocationRepository>()),
    );
    gh.factory<_i90.IsLocationServiceEnabled>(
      () => _i90.IsLocationServiceEnabled(gh<_i332.LocationRepository>()),
    );
    gh.factory<_i90.GetCurrentLocation>(
      () => _i90.GetCurrentLocation(gh<_i332.LocationRepository>()),
    );
    gh.factory<_i90.WatchLocation>(
      () => _i90.WatchLocation(gh<_i332.LocationRepository>()),
    );
    gh.factory<_i90.OpenAppSettings>(
      () => _i90.OpenAppSettings(gh<_i332.LocationRepository>()),
    );
    gh.factory<_i90.OpenLocationSettings>(
      () => _i90.OpenLocationSettings(gh<_i332.LocationRepository>()),
    );
    gh.factory<_i845.LocationBloc>(
      () => _i845.LocationBloc(
        gh<_i90.CheckLocationPermission>(),
        gh<_i90.RequestLocationPermission>(),
        gh<_i90.IsLocationServiceEnabled>(),
        gh<_i90.GetCurrentLocation>(),
        gh<_i90.WatchLocation>(),
        gh<_i90.OpenAppSettings>(),
        gh<_i90.OpenLocationSettings>(),
      ),
    );
    gh.lazySingleton<_i577.RoutingRemoteDataSource>(
      () => _i577.OsrmRemoteDataSource(gh<_i37.OsrmApi>()),
    );
    gh.lazySingleton<_i1054.RoutingRepository>(
      () => _i591.RoutingRepositoryImpl(
        gh<_i577.RoutingRemoteDataSource>(),
        gh<_i226.PolylineDecoder>(),
      ),
    );
    gh.factory<_i333.GetDrivingRoute>(
      () => _i333.GetDrivingRoute(gh<_i1054.RoutingRepository>()),
    );
    gh.factory<_i153.RoutingBloc>(
      () => _i153.RoutingBloc(gh<_i333.GetDrivingRoute>()),
    );
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}

class _$NetworkModule extends _i200.NetworkModule {}

class _$RoutingApiModule extends _i720.RoutingApiModule {}
