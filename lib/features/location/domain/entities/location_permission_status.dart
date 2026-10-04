enum LocationPermissionStatus {
  granted,

  grantedApproximate,

  denied,

  deniedForever;

  bool get isGranted => this == granted || this == grantedApproximate;
}
