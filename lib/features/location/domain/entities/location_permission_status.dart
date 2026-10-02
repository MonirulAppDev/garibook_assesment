enum LocationPermissionStatus {
  /// Precise location granted.
  granted,

  /// Only approximate location (Android 12+ "approximate", iOS reduced
  /// accuracy). Usable, but the UI may hint that precision is limited.
  grantedApproximate,

  /// Not granted yet, or denied but may be asked again.
  denied,

  /// Denied and the OS will not show the dialog again; only Settings helps.
  deniedForever;

  bool get isGranted => this == granted || this == grantedApproximate;
}
