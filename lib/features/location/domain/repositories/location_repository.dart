import '../../../../core/result/result.dart';
import '../entities/location_fix.dart';
import '../entities/location_permission_status.dart';
import '../entities/location_request_options.dart';

abstract interface class LocationRepository {
  Future<Result<LocationPermissionStatus>> checkPermission();

  Future<Result<LocationPermissionStatus>> requestPermission();

  Future<Result<bool>> isServiceEnabled();

  Future<Result<LocationFix>> getCurrentLocation(LocationRequestOptions options);

  Stream<Result<LocationFix>> watchLocation(LocationRequestOptions options);

  Future<Result<bool>> openAppSettings();

  Future<Result<bool>> openLocationSettings();
}
