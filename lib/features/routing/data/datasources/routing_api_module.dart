import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'osrm_api.dart';

@module
abstract class RoutingApiModule {
  @lazySingleton
  OsrmApi osrmApi(@Named('routingDio') Dio dio) => OsrmApi(dio);
}
