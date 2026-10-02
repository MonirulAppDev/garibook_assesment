import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/config/flavor_config.dart';
import '../../../../shared/extensions/geo_point_x.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../location/presentation/bloc/location_bloc.dart';
import '../../../location/presentation/widgets/location_status_panel.dart';
import '../../../navigation/presentation/cubit/navigation_cubit.dart';
import '../../../navigation/presentation/widgets/navigation_panel.dart';
import '../../../navigation/presentation/widgets/navigation_ticker.dart';
import '../../../routing/domain/entities/nav_route.dart';
import '../../../routing/presentation/bloc/routing_bloc.dart';
import '../../../routing/presentation/widgets/route_panel.dart';
import '../widgets/car_layer.dart';
import '../widgets/map_markers_layer.dart';
import '../widgets/osm_attribution.dart';
import '../widgets/route_polyline_layer.dart';

/// The app's single screen. Composes the location, routing and navigation
/// features; their blocs are provided above it by the router.
class MapPage extends StatefulWidget {
  const MapPage({required this.config, super.key});

  final FlavorConfig config;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with WidgetsBindingObserver {
  static const _initialCenter = LatLng(23.8103, 90.4125); // Dhaka
  static const _initialZoom = 13.0;
  static const _userZoom = 16.0;
  static const _followZoom = 16.0;
  static const _routePadding = EdgeInsets.fromLTRB(48, 160, 48, 260);

  /// Map events caused by the user's fingers (not by our controller).
  static const _userGestureSources = {
    MapEventSource.dragStart,
    MapEventSource.onDrag,
    MapEventSource.multiFingerGestureStart,
    MapEventSource.onMultiFinger,
    MapEventSource.flingAnimationController,
    MapEventSource.doubleTap,
    MapEventSource.doubleTapHold,
    MapEventSource.scrollWheel,
  };

  final _mapController = MapController();
  bool _mapReady = false;
  bool _centeredOnUser = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _mapController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final location = context.read<LocationBloc>();
    final navigation = context.read<NavigationCubit>();
    switch (state) {
      case AppLifecycleState.paused || AppLifecycleState.hidden:
        location.add(const LocationAppPaused());
        navigation.appBackgrounded();
      case AppLifecycleState.resumed:
        location.add(const LocationAppResumed());
        navigation.appForegrounded();
      case AppLifecycleState.inactive || AppLifecycleState.detached:
        break;
    }
  }

  // region listeners

  void _onLocationChanged(BuildContext context, LocationState state) {
    context
        .read<RoutingBloc>()
        .add(RouteDeviceLocationChanged(state.fix?.position));

    final fix = state.fix;
    final hasRoute = context.read<RoutingBloc>().state.route != null;
    if (fix != null && !_centeredOnUser && !hasRoute && _mapReady) {
      _centeredOnUser = true;
      _mapController.move(fix.position.toLatLng(), _userZoom);
    }
  }

  void _onRouteChanged(BuildContext context, RoutingState state) {
    context.read<NavigationCubit>().loadRoute(state.route);
    final route = state.route;
    if (route != null) _fitRoute(route);
  }

  void _onNavigationChanged(BuildContext context, NavigationState state) {
    final frame = state.frame;
    if (!_mapReady || frame == null || !state.following || !state.isActive) {
      return;
    }
    final zoom = math.max(_mapController.camera.zoom, _followZoom);
    _mapController.move(frame.position.toLatLng(), zoom);
  }

  // endregion

  void _fitRoute(NavRoute route) {
    if (!_mapReady || route.points.length < 2) return;
    _mapController.fitCamera(
      CameraFit.coordinates(
        coordinates: [for (final p in route.points) p.toLatLng()],
        padding: _routePadding,
      ),
    );
  }

  void _onMapEvent(MapEvent event) {
    if (_userGestureSources.contains(event.source)) {
      context.read<NavigationCubit>().userMovedMap();
    }
  }

  void _onMyLocationPressed() {
    final location = context.read<LocationBloc>().state;
    final fix = location.fix;
    if (fix != null) {
      _mapController.move(fix.position.toLatLng(), _userZoom);
    } else if (!location.isBusy) {
      context.read<LocationBloc>().add(const LocationEnableRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LocationBloc, LocationState>(
          listenWhen: (a, b) => a.fix != b.fix,
          listener: _onLocationChanged,
        ),
        BlocListener<RoutingBloc, RoutingState>(
          listenWhen: (a, b) => a.route != b.route,
          listener: _onRouteChanged,
        ),
        BlocListener<NavigationCubit, NavigationState>(
          listenWhen: (a, b) =>
              a.frame?.position != b.frame?.position ||
              a.following != b.following ||
              a.isActive != b.isActive,
          listener: _onNavigationChanged,
        ),
      ],
      child: NavigationTicker(
        child: Scaffold(
          body: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _initialCenter,
                  initialZoom: _initialZoom,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                  ),
                  onMapReady: () => _mapReady = true,
                  onMapEvent: _onMapEvent,
                  onLongPress: (_, point) => context
                      .read<RoutingBloc>()
                      .add(RouteMapLongPressed(point.toGeoPoint())),
                ),
                children: [
                  TileLayer(
                    urlTemplate: widget.config.tileUrlTemplate,
                    userAgentPackageName: widget.config.packageName,
                  ),
                  const RoutePolylineLayer(),
                  const MapMarkersLayer(),
                  const CarLayer(),
                  const OsmAttribution(),
                ],
              ),
              const SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: LocationStatusPanel(),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.xxl,
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _BottomControls(
                      onMyLocation: _onMyLocationPressed,
                      onClearRoute: () =>
                          context.read<RoutingBloc>().add(const RouteCleared()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomControls extends StatelessWidget {
  const _BottomControls({
    required this.onMyLocation,
    required this.onClearRoute,
  });

  final VoidCallback onMyLocation;
  final VoidCallback onClearRoute;

  @override
  Widget build(BuildContext context) {
    final showRecenter = context.select(
      (NavigationCubit c) => c.state.isActive && !c.state.following,
    );
    final showStartHint = context.select((LocationBloc b) => !b.state.isBusy);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            if (showRecenter)
              FloatingActionButton.extended(
                heroTag: 'recenter',
                onPressed: context.read<NavigationCubit>().recenter,
                icon: const Icon(Icons.navigation),
                label: const Text('Recenter'),
              ),
            const Spacer(),
            FloatingActionButton.small(
              heroTag: 'myLocation',
              tooltip: 'My location',
              onPressed: onMyLocation,
              child: const Icon(Icons.my_location),
            ),
          ],
        ),
        AppSpacing.gapMd,
        RoutePanel(showStartHint: showStartHint),
        AppSpacing.gapSm,
        NavigationPanel(onClose: onClearRoute),
      ],
    );
  }
}
