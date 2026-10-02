import 'package:latlong2/latlong.dart';

import '../../core/geo/geo_point.dart';

/// Adapters between the domain [GeoPoint] and the map package's [LatLng].
/// Lives in `shared` so domain layers never import map packages.
extension GeoPointToLatLng on GeoPoint {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

extension LatLngToGeoPoint on LatLng {
  GeoPoint toGeoPoint() => GeoPoint(latitude: latitude, longitude: longitude);
}
