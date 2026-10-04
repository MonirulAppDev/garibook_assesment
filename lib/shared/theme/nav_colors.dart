import 'package:flutter/material.dart';

import 'app_colors.dart';

@immutable
final class NavColors extends ThemeExtension<NavColors> {
  const NavColors({
    required this.route,
    required this.routeCasing,
    required this.car,
    required this.destination,
    required this.startPoint,
    required this.userLocation,
    required this.devBadge,
  });

  static const light = NavColors(
    route: AppColors.routeLight,
    routeCasing: AppColors.routeCasing,
    car: AppColors.car,
    destination: AppColors.destination,
    startPoint: AppColors.startPoint,
    userLocation: AppColors.userLocation,
    devBadge: AppColors.devBadge,
  );

  static const dark = NavColors(
    route: AppColors.routeDark,
    routeCasing: AppColors.routeCasing,
    car: Colors.white,
    destination: AppColors.destination,
    startPoint: AppColors.startPoint,
    userLocation: AppColors.routeDark,
    devBadge: AppColors.devBadge,
  );

  final Color route;
  final Color routeCasing;
  final Color car;
  final Color destination;
  final Color startPoint;
  final Color userLocation;
  final Color devBadge;

  @override
  NavColors copyWith({
    Color? route,
    Color? routeCasing,
    Color? car,
    Color? destination,
    Color? startPoint,
    Color? userLocation,
    Color? devBadge,
  }) =>
      NavColors(
        route: route ?? this.route,
        routeCasing: routeCasing ?? this.routeCasing,
        car: car ?? this.car,
        destination: destination ?? this.destination,
        startPoint: startPoint ?? this.startPoint,
        userLocation: userLocation ?? this.userLocation,
        devBadge: devBadge ?? this.devBadge,
      );

  @override
  NavColors lerp(NavColors? other, double t) {
    if (other == null) return this;
    return NavColors(
      route: Color.lerp(route, other.route, t)!,
      routeCasing: Color.lerp(routeCasing, other.routeCasing, t)!,
      car: Color.lerp(car, other.car, t)!,
      destination: Color.lerp(destination, other.destination, t)!,
      startPoint: Color.lerp(startPoint, other.startPoint, t)!,
      userLocation: Color.lerp(userLocation, other.userLocation, t)!,
      devBadge: Color.lerp(devBadge, other.devBadge, t)!,
    );
  }
}
