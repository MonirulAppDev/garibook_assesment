import 'package:injectable/injectable.dart';

import '../../../../core/geo/geo_point.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/nav_route.dart';
import '../../domain/failures/routing_failure.dart';
import '../../domain/repositories/routing_repository.dart';
import '../datasources/routing_remote_data_source.dart';
import '../mappers/polyline_decoder.dart';
import '../models/routing_exception.dart';

@LazySingleton(as: RoutingRepository)
final class RoutingRepositoryImpl implements RoutingRepository {
  const RoutingRepositoryImpl(this._remote, this._decoder);

  final RoutingRemoteDataSource _remote;
  final PolylineDecoder _decoder;

  @override
  Future<Result<NavRoute>> getDrivingRoute({
    required GeoPoint from,
    required GeoPoint to,
  }) async {
    try {
      final dto = await _remote.fetchDrivingRoute(from, to);
      final points = _decoder.decode(dto.geometry);
      if (points.length < 2) return const Err(NoRouteFound());
      return Ok(
        NavRoute(
          origin: from,
          destination: to,
          points: points,
          distanceMeters: dto.distance,
          durationSeconds: dto.duration,
        ),
      );
    } on RoutingException catch (e) {
      return Err(_toFailure(e));
    }
  }

  static RoutingFailure _toFailure(RoutingException e) => switch (e.type) {
        RoutingErrorType.noRoute => const NoRouteFound(),
        RoutingErrorType.network => const RoutingNetworkFailure(),
        RoutingErrorType.timeout => const RoutingTimeout(),
        RoutingErrorType.rateLimited => const RoutingRateLimited(),
        RoutingErrorType.server => const RoutingServerFailure(),
        RoutingErrorType.badResponse => const RoutingBadResponse(),
        RoutingErrorType.cancelled => const RoutingCancelled(),
      };
}
