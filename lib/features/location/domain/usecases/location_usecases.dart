import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/location_fix.dart';
import '../entities/location_permission_status.dart';
import '../entities/location_request_options.dart';
import '../repositories/location_repository.dart';

@injectable
final class CheckLocationPermission
    implements UseCase<LocationPermissionStatus, NoParams> {
  const CheckLocationPermission(this._repository);
  final LocationRepository _repository;

  @override
  Future<Result<LocationPermissionStatus>> call(NoParams _) =>
      _repository.checkPermission();
}

@injectable
final class RequestLocationPermission
    implements UseCase<LocationPermissionStatus, NoParams> {
  const RequestLocationPermission(this._repository);
  final LocationRepository _repository;

  @override
  Future<Result<LocationPermissionStatus>> call(NoParams _) =>
      _repository.requestPermission();
}

@injectable
final class IsLocationServiceEnabled implements UseCase<bool, NoParams> {
  const IsLocationServiceEnabled(this._repository);
  final LocationRepository _repository;

  @override
  Future<Result<bool>> call(NoParams _) => _repository.isServiceEnabled();
}

@injectable
final class GetCurrentLocation
    implements UseCase<LocationFix, LocationRequestOptions> {
  const GetCurrentLocation(this._repository);
  final LocationRepository _repository;

  @override
  Future<Result<LocationFix>> call(LocationRequestOptions options) =>
      _repository.getCurrentLocation(options);
}

@injectable
final class WatchLocation
    implements StreamUseCase<LocationFix, LocationRequestOptions> {
  const WatchLocation(this._repository);
  final LocationRepository _repository;

  @override
  Stream<Result<LocationFix>> call(LocationRequestOptions options) =>
      _repository.watchLocation(options);
}

@injectable
final class OpenAppSettings implements UseCase<bool, NoParams> {
  const OpenAppSettings(this._repository);
  final LocationRepository _repository;

  @override
  Future<Result<bool>> call(NoParams _) => _repository.openAppSettings();
}

@injectable
final class OpenLocationSettings implements UseCase<bool, NoParams> {
  const OpenLocationSettings(this._repository);
  final LocationRepository _repository;

  @override
  Future<Result<bool>> call(NoParams _) => _repository.openLocationSettings();
}
