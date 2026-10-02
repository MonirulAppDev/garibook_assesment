import '../../../../core/result/result.dart';
import '../entities/location_fix.dart';
import '../entities/location_permission_status.dart';
import '../entities/location_request_options.dart';

/// Location capabilities the app needs, independent of platform channels.
abstract interface class LocationRepository {
  Future<Result<LocationPermissionStatus>> checkPermission();

  Future<Result<LocationPermissionStatus>> requestPermission();

  Future<Result<bool>> isServiceEnabled();

  Future<Result<LocationFix>> getCurrentLocation(LocationRequestOptions options);

  /// Live updates. Cancelling the subscription stops native updates.
  Stream<Result<LocationFix>> watchLocation(LocationRequestOptions options);

  Future<Result<bool>> openAppSettings();

  Future<Result<bool>> openLocationSettings();
}
