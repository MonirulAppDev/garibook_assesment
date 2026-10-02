import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_request_options.freezed.dart';

@freezed
abstract class LocationRequestOptions with _$LocationRequestOptions {
  const factory LocationRequestOptions({
    @Default(true) bool highAccuracy,
    @Default(Duration(seconds: 15)) Duration timeout,
    @Default(Duration(seconds: 1)) Duration interval,
    @Default(0.0) double minDistanceMeters,
  }) = _LocationRequestOptions;
}
