// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'osrm_route_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OsrmRouteResponse _$OsrmRouteResponseFromJson(Map<String, dynamic> json) =>
    _OsrmRouteResponse(
      code: json['code'] as String,
      message: json['message'] as String?,
      routes:
          (json['routes'] as List<dynamic>?)
              ?.map((e) => OsrmRouteDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <OsrmRouteDto>[],
    );

Map<String, dynamic> _$OsrmRouteResponseToJson(_OsrmRouteResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'routes': instance.routes,
    };

_OsrmRouteDto _$OsrmRouteDtoFromJson(Map<String, dynamic> json) =>
    _OsrmRouteDto(
      distance: (json['distance'] as num).toDouble(),
      duration: (json['duration'] as num).toDouble(),
      geometry: json['geometry'] as String,
    );

Map<String, dynamic> _$OsrmRouteDtoToJson(_OsrmRouteDto instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'geometry': instance.geometry,
    };
