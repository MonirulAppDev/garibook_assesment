import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flavor.dart';
import 'flavor_config.dart';

abstract final class FlavorConfigLoader {
  static const _assetDir = 'assets/config';

  static Flavor resolveFlavor([String? rawFlavor = appFlavor]) {
    if (rawFlavor == null) {
      if (kReleaseMode) {
        throw StateError('No flavor supplied. Build with --flavor dev|prod.');
      }
      return Flavor.dev;
    }
    return Flavor.values.firstWhere(
      (f) => f.name == rawFlavor,
      orElse: () => throw StateError('Unknown flavor "$rawFlavor".'),
    );
  }

  static Future<FlavorConfig> load(
    Flavor flavor, {
    AssetBundle? bundle,
  }) async {
    final raw = await (bundle ?? rootBundle)
        .loadString('$_assetDir/${flavor.name}.json');
    return FlavorConfig.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }
}
