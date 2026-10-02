import 'package:freezed_annotation/freezed_annotation.dart';

import 'flavor.dart';

part 'flavor_config.freezed.dart';
part 'flavor_config.g.dart';

/// Runtime configuration for a single build flavor.
///
/// Loaded from `assets/config/<flavor>.json`; changing a server URL is a
/// config-only change, no code involved.
@freezed
abstract class FlavorConfig with _$FlavorConfig {
  const factory FlavorConfig({
    required Flavor flavor,
    required String appName,
    required String packageName,
    required String osrmBaseUrl,
    required String tileUrlTemplate,
    @Default(false) bool showDevBadge,
    @Default(false) bool enableNetworkLogs,
    @Default(8000) int connectTimeoutMs,
    @Default(12000) int receiveTimeoutMs,
  }) = _FlavorConfig;

  const FlavorConfig._();

  factory FlavorConfig.fromJson(Map<String, dynamic> json) =>
      _$FlavorConfigFromJson(json);

  bool get isDev => flavor == Flavor.dev;
}
