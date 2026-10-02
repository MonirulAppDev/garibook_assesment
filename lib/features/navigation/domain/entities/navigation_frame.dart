import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/geo/geo_point.dart';
import 'navigation_status.dart';

part 'navigation_frame.freezed.dart';

/// Immutable snapshot of the simulated car, produced once per tick by the
/// (pure Dart) route animator and rendered by the map layer.
@freezed
abstract class NavigationFrame with _$NavigationFrame {
  const factory NavigationFrame({
    required GeoPoint position,
    required double bearingDegrees,
    required double travelledMeters,
    required double remainingMeters,
    required Duration remainingTime,
    required NavigationStatus status,
    required SpeedMultiplier speed,
  }) = _NavigationFrame;

  const NavigationFrame._();

  double get progress {
    final total = travelledMeters + remainingMeters;
    return total > 0 ? (travelledMeters / total).clamp(0.0, 1.0) : 1.0;
  }
}
