import 'package:latlong2/latlong.dart';

import '../../core/geo/geo_point.dart';

extension GeoPointToLatLng on GeoPoint {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

extension LatLngToGeoPoint on LatLng {
  GeoPoint toGeoPoint() => GeoPoint(latitude: latitude, longitude: longitude);
}
