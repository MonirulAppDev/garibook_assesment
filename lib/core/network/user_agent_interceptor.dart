import 'package:dio/dio.dart';

/// Identifies the app to shared public services (OSM/OSRM usage policies).
final class UserAgentInterceptor extends Interceptor {
  UserAgentInterceptor(this.packageName);

  final String packageName;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['User-Agent'] = '$packageName (flutter)';
    handler.next(options);
  }
}
