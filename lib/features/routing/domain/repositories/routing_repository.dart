import '../../../../core/geo/geo_point.dart';
import '../../../../core/result/result.dart';
import '../entities/nav_route.dart';

abstract interface class RoutingRepository {
  Future<Result<NavRoute>> getDrivingRoute({
    required GeoPoint from,
    required GeoPoint to,
  });
}
