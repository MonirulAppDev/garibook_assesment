import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/geo/geo_point.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/nav_route.dart';
import '../failures/routing_failure.dart';
import '../repositories/routing_repository.dart';

part 'get_driving_route.freezed.dart';

@freezed
abstract class RouteParams with _$RouteParams {
  const factory RouteParams({
    required GeoPoint from,
    required GeoPoint to,
  }) = _RouteParams;
}

@injectable
final class GetDrivingRoute implements UseCase<NavRoute, RouteParams> {
  const GetDrivingRoute(this._repository);

  final RoutingRepository _repository;

  @override
  Future<Result<NavRoute>> call(RouteParams params) async {
    if (!params.from.isValid || !params.to.isValid) {
      return const Err(RoutingBadResponse('Invalid coordinates'));
    }
    return _repository.getDrivingRoute(from: params.from, to: params.to);
  }
}
