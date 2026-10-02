import 'package:freezed_annotation/freezed_annotation.dart';

part 'osrm_route_response.freezed.dart';
part 'osrm_route_response.g.dart';

/// Subset of the OSRM `/route` response we consume.
@freezed
abstract class OsrmRouteResponse with _$OsrmRouteResponse {
  const factory OsrmRouteResponse({
    required String code,
    String? message,
    @Default(<OsrmRouteDto>[]) List<OsrmRouteDto> routes,
  }) = _OsrmRouteResponse;

  factory OsrmRouteResponse.fromJson(Map<String, dynamic> json) =>
      _$OsrmRouteResponseFromJson(json);
}

@freezed
abstract class OsrmRouteDto with _$OsrmRouteDto {
  const factory OsrmRouteDto({
    required double distance,
    required double duration,
    required String geometry,
  }) = _OsrmRouteDto;

  factory OsrmRouteDto.fromJson(Map<String, dynamic> json) =>
      _$OsrmRouteDtoFromJson(json);
}
