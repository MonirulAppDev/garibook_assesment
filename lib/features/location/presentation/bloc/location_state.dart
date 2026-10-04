part of 'location_bloc.dart';

enum LocationStatus {
  initial,
  checking,

  needsPermission,
  requesting,
  acquiring,
  ready,
  failure,
}

@freezed
abstract class LocationState with _$LocationState {
  const factory LocationState({
    @Default(LocationStatus.initial) LocationStatus status,
    LocationPermissionStatus? permission,

    LocationFix? fix,
    LocationFailure? failure,
    @Default(false) bool promptDismissed,
  }) = _LocationState;

  const LocationState._();

  bool get isBusy =>
      status == LocationStatus.checking ||
      status == LocationStatus.requesting ||
      status == LocationStatus.acquiring;

  bool get hasFix => fix != null;
}
