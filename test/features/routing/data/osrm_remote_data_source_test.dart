import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garibook_assesment/core/geo/geo_point.dart';
import 'package:garibook_assesment/features/routing/data/datasources/osrm_api.dart';
import 'package:garibook_assesment/features/routing/data/datasources/routing_remote_data_source.dart';
import 'package:garibook_assesment/features/routing/data/models/routing_exception.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart' hide Matcher;

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late OsrmRemoteDataSource dataSource;

  const from = GeoPoint(latitude: 23.8, longitude: 90.4);
  const to = GeoPoint(latitude: 23.9, longitude: 90.5);
  const path = '/route/v1/driving/90.4,23.8;90.5,23.9';

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://osrm.test'));
    adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
    dataSource = OsrmRemoteDataSource(OsrmApi(dio));
  });

  Matcher throwsRouting(RoutingErrorType type) => throwsA(
        isA<RoutingException>().having((e) => e.type, 'type', type),
      );

  test('builds a lng,lat URL and parses the first route', () async {
    adapter.onGet(
      path,
      (server) => server.reply(200, {
        'code': 'Ok',
        'routes': [
          {'distance': 1234.5, 'duration': 321, 'geometry': '_p~iF~ps|U'},
        ],
      }),
    );

    final dto = await dataSource.fetchDrivingRoute(from, to);
    expect(dto.distance, 1234.5);
    expect(dto.duration, 321);
    expect(dto.geometry, '_p~iF~ps|U');
  });

  test('HTTP 400 NoRoute -> noRoute', () async {
    adapter.onGet(
      path,
      (server) => server.reply(400, {'code': 'NoRoute', 'message': 'none'}),
    );
    expect(
      dataSource.fetchDrivingRoute(from, to),
      throwsRouting(RoutingErrorType.noRoute),
    );
  });

  test('Ok with empty routes -> noRoute', () async {
    adapter.onGet(
      path,
      (server) => server.reply(200, {'code': 'Ok', 'routes': <Object>[]}),
    );
    expect(
      dataSource.fetchDrivingRoute(from, to),
      throwsRouting(RoutingErrorType.noRoute),
    );
  });

  test('HTTP 429 -> rateLimited', () async {
    adapter.onGet(path, (server) => server.reply(429, 'slow down'));
    expect(
      dataSource.fetchDrivingRoute(from, to),
      throwsRouting(RoutingErrorType.rateLimited),
    );
  });

  test('HTTP 503 -> server', () async {
    adapter.onGet(path, (server) => server.reply(503, 'down'));
    expect(
      dataSource.fetchDrivingRoute(from, to),
      throwsRouting(RoutingErrorType.server),
    );
  });

  test('receive timeout -> timeout', () async {
    adapter.onGet(
      path,
      (server) => server.throws(
        0,
        DioException.receiveTimeout(
          timeout: const Duration(seconds: 1),
          requestOptions: RequestOptions(path: path),
        ),
      ),
    );
    expect(
      dataSource.fetchDrivingRoute(from, to),
      throwsRouting(RoutingErrorType.timeout),
    );
  });

  test('connection error -> network', () async {
    adapter.onGet(
      path,
      (server) => server.throws(
        0,
        DioException.connectionError(
          requestOptions: RequestOptions(path: path),
          reason: 'offline',
        ),
      ),
    );
    expect(
      dataSource.fetchDrivingRoute(from, to),
      throwsRouting(RoutingErrorType.network),
    );
  });

  test('malformed body -> badResponse', () async {
    adapter.onGet(path, (server) => server.reply(200, {'unexpected': true}));
    expect(
      dataSource.fetchDrivingRoute(from, to),
      throwsRouting(RoutingErrorType.badResponse),
    );
  });
}
