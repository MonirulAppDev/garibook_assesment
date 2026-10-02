import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/location_fix.dart';
import '../../domain/entities/location_permission_status.dart';
import '../../domain/entities/location_request_options.dart';
import '../models/location_exception.dart';
import '../models/location_fix_model.dart';
import 'location_channel_contract.dart';

/// Raw access to the native location layer. Throws [LocationException].
abstract interface class LocationPlatformDataSource {
  Future<LocationPermissionStatus> checkPermission();
  Future<LocationPermissionStatus> requestPermission();
  Future<bool> isServiceEnabled();
  Future<LocationFix> getCurrentLocation(LocationRequestOptions options);
  Stream<LocationFix> watchLocation(LocationRequestOptions options);
  Future<bool> openAppSettings();
  Future<bool> openLocationSettings();
}

/// The ONLY class in the app that touches the location platform channels.
@LazySingleton(as: LocationPlatformDataSource)
final class MethodChannelLocationDataSource
    implements LocationPlatformDataSource {
  MethodChannelLocationDataSource()
      : _methods = const MethodChannel(LocationChannelContract.methodChannel),
        _events = const EventChannel(LocationChannelContract.eventChannel);

  @visibleForTesting
  MethodChannelLocationDataSource.withChannels(this._methods, this._events);

  final MethodChannel _methods;
  final EventChannel _events;

  @override
  Future<LocationPermissionStatus> checkPermission() async =>
      _parsePermission(await _invoke<String>(LocationChannelContract.checkPermission));

  @override
  Future<LocationPermissionStatus> requestPermission() async =>
      _parsePermission(await _invoke<String>(LocationChannelContract.requestPermission));

  @override
  Future<bool> isServiceEnabled() async =>
      await _invoke<bool>(LocationChannelContract.isServiceEnabled) ?? false;

  @override
  Future<LocationFix> getCurrentLocation(LocationRequestOptions options) async {
    final raw = await _invoke<Map<Object?, Object?>>(
      LocationChannelContract.getCurrentLocation,
      {
        LocationChannelContract.argHighAccuracy: options.highAccuracy,
        LocationChannelContract.argTimeoutMs: options.timeout.inMilliseconds,
      },
    );
    return LocationFixModel.fromChannel(raw);
  }

  @override
  Stream<LocationFix> watchLocation(LocationRequestOptions options) {
    // receiveBroadcastStream: native onListen on first listener, onCancel
    // (which must stop native updates) when the last listener cancels.
    return _events
        .receiveBroadcastStream({
          LocationChannelContract.argHighAccuracy: options.highAccuracy,
          LocationChannelContract.argIntervalMs: options.interval.inMilliseconds,
          LocationChannelContract.argMinDistanceM: options.minDistanceMeters,
        })
        .map(LocationFixModel.fromChannel)
        .handleError(
          (Object e, StackTrace st) => Error.throwWithStackTrace(_mapError(e), st),
        );
  }

  @override
  Future<bool> openAppSettings() async =>
      await _invoke<bool>(LocationChannelContract.openAppSettings) ?? false;

  @override
  Future<bool> openLocationSettings() async =>
      await _invoke<bool>(LocationChannelContract.openLocationSettings) ?? false;

  Future<T?> _invoke<T>(String method, [Object? args]) async {
    try {
      return await _methods.invokeMethod<T>(method, args);
    } catch (e) {
      throw _mapError(e);
    }
  }

  static LocationException _mapError(Object e) => switch (e) {
        LocationException() => e,
        MissingPluginException() => const LocationException.notSupported(),
        PlatformException(:final code, :final message) =>
          LocationException(code, message),
        _ => LocationException(LocationChannelContract.errUnknown, '$e'),
      };

  static LocationPermissionStatus _parsePermission(String? raw) =>
      switch (raw) {
        LocationChannelContract.permissionGranted =>
          LocationPermissionStatus.granted,
        LocationChannelContract.permissionGrantedApproximate =>
          LocationPermissionStatus.grantedApproximate,
        LocationChannelContract.permissionDeniedForever =>
          LocationPermissionStatus.deniedForever,
        LocationChannelContract.permissionDenied =>
          LocationPermissionStatus.denied,
        _ => throw LocationException.malformed('Unknown permission "$raw"'),
      };
}
