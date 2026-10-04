import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/geo/geo_point.dart';
import '../models/osrm_route_response.dart';
import '../models/routing_exception.dart';
import 'osrm_api.dart';

abstract interface class RoutingRemoteDataSource {
  Future<OsrmRouteDto> fetchDrivingRoute(GeoPoint from, GeoPoint to);
}

@LazySingleton(as: RoutingRemoteDataSource)
final class OsrmRemoteDataSource implements RoutingRemoteDataSource {
  OsrmRemoteDataSource(this._api);

  final OsrmApi _api;
  CancelToken? _inFlight;

  static const _noRouteCodes = {'NoRoute', 'NoSegment'};

  @override
  Future<OsrmRouteDto> fetchDrivingRoute(GeoPoint from, GeoPoint to) async {
    _inFlight?.cancel('superseded');
    final token = _inFlight = CancelToken();
    try {
      final response = await _api.getRoute(
        '${from.longitude},${from.latitude};${to.longitude},${to.latitude}',
        cancelToken: token,
      );
      if (_noRouteCodes.contains(response.code) ||
          (response.code == 'Ok' && response.routes.isEmpty)) {
        throw RoutingException(RoutingErrorType.noRoute, response.message);
      }
      if (response.code != 'Ok') {
        throw RoutingException(RoutingErrorType.badResponse, response.code);
      }
      return response.routes.first;
    } on DioException catch (e) {
      throw _mapDio(e);
    } on RoutingException {
      rethrow;
    } catch (e) {
      throw RoutingException(RoutingErrorType.badResponse, '$e');
    } finally {
      if (identical(_inFlight, token)) _inFlight = null;
    }
  }

  static RoutingException _mapDio(DioException e) => switch (e.type) {
        DioExceptionType.cancel =>
          const RoutingException(RoutingErrorType.cancelled),
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout =>
          const RoutingException(RoutingErrorType.timeout),
        DioExceptionType.connectionError =>
          RoutingException(RoutingErrorType.network, e.message),
        DioExceptionType.badResponse => _mapBadResponse(e.response),
        _ => RoutingException(RoutingErrorType.network, e.message),
      };

  static RoutingException _mapBadResponse(Response<dynamic>? response) {
    final data = response?.data;
    if (data is Map && _noRouteCodes.contains(data['code'])) {
      return RoutingException(
        RoutingErrorType.noRoute,
        data['message'] as String?,
      );
    }
    return _mapStatus(response?.statusCode);
  }

  static RoutingException _mapStatus(int? status) => switch (status) {
        429 => const RoutingException(RoutingErrorType.rateLimited),
        final s? when s >= 500 =>
          RoutingException(RoutingErrorType.server, 'HTTP $s'),
        _ => RoutingException(RoutingErrorType.badResponse, 'HTTP $status'),
      };
}
