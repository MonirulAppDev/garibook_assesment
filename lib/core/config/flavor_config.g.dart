// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flavor_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FlavorConfig _$FlavorConfigFromJson(Map<String, dynamic> json) =>
    _FlavorConfig(
      flavor: $enumDecode(_$FlavorEnumMap, json['flavor']),
      appName: json['appName'] as String,
      packageName: json['packageName'] as String,
      osrmBaseUrl: json['osrmBaseUrl'] as String,
      tileUrlTemplate: json['tileUrlTemplate'] as String,
      showDevBadge: json['showDevBadge'] as bool? ?? false,
      enableNetworkLogs: json['enableNetworkLogs'] as bool? ?? false,
      connectTimeoutMs: (json['connectTimeoutMs'] as num?)?.toInt() ?? 8000,
      receiveTimeoutMs: (json['receiveTimeoutMs'] as num?)?.toInt() ?? 12000,
    );

Map<String, dynamic> _$FlavorConfigToJson(_FlavorConfig instance) =>
    <String, dynamic>{
      'flavor': _$FlavorEnumMap[instance.flavor]!,
      'appName': instance.appName,
      'packageName': instance.packageName,
      'osrmBaseUrl': instance.osrmBaseUrl,
      'tileUrlTemplate': instance.tileUrlTemplate,
      'showDevBadge': instance.showDevBadge,
      'enableNetworkLogs': instance.enableNetworkLogs,
      'connectTimeoutMs': instance.connectTimeoutMs,
      'receiveTimeoutMs': instance.receiveTimeoutMs,
    };

const _$FlavorEnumMap = {Flavor.dev: 'dev', Flavor.prod: 'prod'};
