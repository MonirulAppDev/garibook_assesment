import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/flavor_config.dart';
import 'user_agent_interceptor.dart';

@module
abstract class NetworkModule {
  /// Dio instance for the routing server. Base URL and timeouts come from
  /// the flavor config, never from app logic.
  @Named('routingDio')
  @lazySingleton
  Dio routingDio(FlavorConfig config) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.osrmBaseUrl,
        connectTimeout: Duration(milliseconds: config.connectTimeoutMs),
        receiveTimeout: Duration(milliseconds: config.receiveTimeoutMs),
        responseType: ResponseType.json,
      ),
    );
    dio.interceptors.add(UserAgentInterceptor(config.packageName));
    if (config.enableNetworkLogs) {
      dio.interceptors.add(
        PrettyDioLogger(requestHeader: false, responseBody: false),
      );
    }
    return dio;
  }
}
