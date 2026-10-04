import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/extensions/geo_point_x.dart';
import '../../../routing/domain/entities/nav_route.dart';
import '../../../routing/presentation/bloc/routing_bloc.dart';

class RoutePolylineLayer extends StatelessWidget {
  const RoutePolylineLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RoutingBloc, RoutingState, NavRoute?>(
      selector: (state) => state.route,
      builder: (context, route) {
        if (route == null) return const SizedBox.shrink();
        return _RoutePolyline(route: route);
      },
    );
  }
}

class _RoutePolyline extends StatelessWidget {
  const _RoutePolyline({required this.route});

  final NavRoute route;

  @override
  Widget build(BuildContext context) {
    final colors = context.navColors;
    final points = <LatLng>[for (final p in route.points) p.toLatLng()];
    return PolylineLayer(
      polylines: [
        Polyline(
          points: points,
          strokeWidth: 6,
          color: colors.route,
          borderStrokeWidth: 2,
          borderColor: colors.routeCasing,
          strokeCap: StrokeCap.round,
          strokeJoin: StrokeJoin.round,
        ),
      ],
    );
  }
}
