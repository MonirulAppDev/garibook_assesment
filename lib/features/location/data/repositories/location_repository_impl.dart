import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../../domain/entities/location_fix.dart';
import '../../domain/entities/location_permission_status.dart';
import '../../domain/entities/location_request_options.dart';
import '../../domain/failures/location_failure.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_channel_contract.dart';
import '../datasources/location_platform_data_source.dart';
import '../models/location_exception.dart';

@LazySingleton(as: LocationRepository)
final class LocationRepositoryImpl implements LocationRepository {
  const LocationRepositoryImpl(this._dataSource);

  final LocationPlatformDataSource _dataSource;

  @override
  Future<Result<LocationPermissionStatus>> checkPermission() =>
      _guard(_dataSource.checkPermission);

  @override
  Future<Result<LocationPermissionStatus>> requestPermission() =>
      _guard(_dataSource.requestPermission);

  @override
  Future<Result<bool>> isServiceEnabled() =>
      _guard(_dataSource.isServiceEnabled);

  @override
  Future<Result<LocationFix>> getCurrentLocation(
    LocationRequestOptions options,
  ) =>
      _guard(() => _dataSource.getCurrentLocation(options));

  @override
  Stream<Result<LocationFix>> watchLocation(LocationRequestOptions options) =>
      _dataSource.watchLocation(options).transform(
            StreamTransformer.fromHandlers(
              handleData: (fix, sink) => sink.add(Ok(fix)),
              handleError: (error, _, sink) => sink.add(Err(_toFailure(error))),
            ),
          );

  @override
  Future<Result<bool>> openAppSettings() => _guard(_dataSource.openAppSettings);

  @override
  Future<Result<bool>> openLocationSettings() =>
      _guard(_dataSource.openLocationSettings);

  Future<Result<T>> _guard<T>(Future<T> Function() action) async {
    try {
      return Ok(await action());
    } catch (e) {
      return Err(_toFailure(e));
    }
  }

  static LocationFailure _toFailure(Object error) {
    if (error is! LocationException) {
      return LocationUnknownFailure('$error');
    }
    return switch (error.code) {
      LocationChannelContract.errPermissionDenied =>
        const LocationPermissionDenied(),
      LocationChannelContract.errPermissionDeniedForever =>
        const LocationPermissionDeniedForever(),
      LocationChannelContract.errServicesDisabled =>
        const LocationServiceDisabled(),
      LocationChannelContract.errTimeout => const LocationTimeout(),
      LocationException.notSupportedCode => const LocationNotSupported(),
      LocationChannelContract.errRequestInProgress ||
      LocationChannelContract.errNoActivity ||
      LocationChannelContract.errPlayServicesUnavailable =>
        LocationUnavailable(error.message ?? error.code),
      _ => LocationUnknownFailure(error.message ?? error.code),
    };
  }
}
