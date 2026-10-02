import '../../../../core/geo/geo_point.dart';
import '../../../../core/result/result.dart';
import '../entities/nav_route.dart';

abstract interface class RoutingRepository {
  /// Fetches a driving route. Starting a new request supersedes any
  /// in-flight one, which then completes with `RoutingCancelled`.
  Future<Result<NavRoute>> getDrivingRoute({
    required GeoPoint from,
    required GeoPoint to,
  });
}
