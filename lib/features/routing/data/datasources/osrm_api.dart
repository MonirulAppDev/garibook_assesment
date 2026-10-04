import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/osrm_route_response.dart';

part 'osrm_api.g.dart';

@RestApi()
abstract class OsrmApi {
  factory OsrmApi(Dio dio) = _OsrmApi;

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
