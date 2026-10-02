import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/osrm_route_response.dart';

part 'osrm_api.g.dart';

/// OSRM HTTP API. Base URL is injected from the flavor config via Dio.
@RestApi()
abstract class OsrmApi {
  factory OsrmApi(Dio dio) = _OsrmApi;

  /// [coordinates] is `lng,lat;lng,lat` — OSRM uses longitude first.
  @GET('/route/v1/driving/{coordinates}')
  Future<OsrmRouteResponse> getRoute(
    @Path('coordinates') String coordinates, {
    @Query('overview') String overview = 'full',
    @Query('geometries') String geometries = 'polyline',
    @Query('alternatives') bool alternatives = false,
    @Query('steps') bool steps = false,
    @CancelRequest() CancelToken? cancelToken,
  });
}
