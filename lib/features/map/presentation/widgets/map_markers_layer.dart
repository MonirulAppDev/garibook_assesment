import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/extensions/geo_point_x.dart';
import '../../../location/presentation/bloc/location_bloc.dart';
import '../../../routing/presentation/bloc/routing_bloc.dart';

class MapMarkersLayer extends StatelessWidget {
  const MapMarkersLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.navColors;
    final userFix = context.select((LocationBloc b) => b.state.fix);
    final routing = context.watch<RoutingBloc>().state;

    return MarkerLayer(
      markers: [
        if (userFix != null)
          Marker(
            point: userFix.position.toLatLng(),
            width: 22,
            height: 22,
            child: _UserDot(color: colors.userLocation),
          ),
        if (routing.manualOrigin case final origin?)
          Marker(
            point: origin.toLatLng(),
            width: 36,
            height: 36,
            child: Icon(Icons.trip_origin, color: colors.startPoint, size: 28),
          ),
        if (routing.destination case final destination?)
          Marker(
            point: destination.toLatLng(),
            width: 44,
            height: 44,
            alignment: Alignment.topCenter,
            child: Icon(Icons.place, color: colors.destination, size: 44),
          ),
      ],
    );
  }
}

class _UserDot extends StatelessWidget {
  const _UserDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
      ),
    );
  }
}
