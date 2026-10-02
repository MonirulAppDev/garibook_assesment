import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flavor.dart';
import 'flavor_config.dart';

/// Resolves the active flavor and loads its JSON configuration.
abstract final class FlavorConfigLoader {
  static const _assetDir = 'assets/config';

  /// `appFlavor` is set by `flutter run --flavor <name>`.
  ///
  /// When no flavor is passed (e.g. `flutter test` or a plain `flutter run`)
  /// we fall back to [Flavor.dev] in debug builds only; a release build
  /// without a flavor is a packaging error and fails fast.
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
