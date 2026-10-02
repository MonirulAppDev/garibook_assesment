import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/extensions/geo_point_x.dart';
import '../../../navigation/domain/entities/navigation_frame.dart';
import '../../../navigation/presentation/cubit/navigation_cubit.dart';
import '../../../navigation/presentation/widgets/car_marker.dart';

/// Only this layer rebuilds per animation frame.
class CarLayer extends StatelessWidget {
  const CarLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NavigationCubit, NavigationState, NavigationFrame?>(
      selector: (s) => s.frame,
      builder: (context, frame) {
        if (frame == null) return const SizedBox.shrink();
        return MarkerLayer(
          markers: [
            Marker(
              point: frame.position.toLatLng(),
              width: 40,
              height: 40,
              child: CarMarker(
                bearingDegrees: frame.bearingDegrees,
                color: context.navColors.car,
              ),
            ),
          ],
        );
      },
    );
  }
}
