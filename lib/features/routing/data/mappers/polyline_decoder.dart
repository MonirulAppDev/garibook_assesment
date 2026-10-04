import 'package:injectable/injectable.dart';

import '../../../../core/geo/geo_point.dart';

@lazySingleton
final class PolylineDecoder {
  const PolylineDecoder();

  List<GeoPoint> decode(String encoded, {int precision = 5}) {
    final factor = _pow10(precision);
    final points = <GeoPoint>[];
    var index = 0;
    var lat = 0;
    var lng = 0;

    while (index < encoded.length) {
      final dLat = _next(encoded, index);
      if (dLat == null) break;
      index = dLat.$2;
      final dLng = _next(encoded, index);
      if (dLng == null) break;
      index = dLng.$2;

      lat += dLat.$1;
      lng += dLng.$1;
      points.add(GeoPoint(latitude: lat / factor, longitude: lng / factor));
    }
    return points;
  }

  static (int, int)? _next(String s, int start) {
    var result = 0;
    var shift = 0;
    var i = start;
    while (i < s.length) {
      final b = s.codeUnitAt(i++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
      if (b < 0x20) {
        final value = (result & 1) != 0 ? ~(result >> 1) : result >> 1;
        return (value, i);
      }
    }
    return null;
  }

  static double _pow10(int p) {
    var v = 1.0;
    for (var i = 0; i < p; i++) {
      v *= 10;
    }
    return v;
  }
}
