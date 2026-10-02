// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_request_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationRequestOptions {

 bool get highAccuracy; Duration get timeout; Duration get interval; double get minDistanceMeters;
/// Create a copy of LocationRequestOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationRequestOptionsCopyWith<LocationRequestOptions> get copyWith => _$LocationRequestOptionsCopyWithImpl<LocationRequestOptions>(this as LocationRequestOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocationRequestOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationRequestOptions&&(identical(other.highAccuracy, _this.highAccuracy) || other.highAccuracy == _this.highAccuracy)&&(identical(other.timeout, _this.timeout) || other.timeout == _this.timeout)&&(identical(other.interval, _this.interval) || other.interval == _this.interval)&&(identical(other.minDistanceMeters, _this.minDistanceMeters) || other.minDistanceMeters == _this.minDistanceMeters));
}


@override
int get hashCode {
  final _this = this as LocationRequestOptions;
  return Object.hash(runtimeType,_this.highAccuracy,_this.timeout,_this.interval,_this.minDistanceMeters);
}

@override
String toString() {
  final _this = this as LocationRequestOptions;
  return 'LocationRequestOptions(highAccuracy: ${_this.highAccuracy}, timeout: ${_this.timeout}, interval: ${_this.interval}, minDistanceMeters: ${_this.minDistanceMeters})';
}


}

/// @nodoc
abstract mixin class $LocationRequestOptionsCopyWith<$Res>  {
  factory $LocationRequestOptionsCopyWith(LocationRequestOptions value, $Res Function(LocationRequestOptions) _then) = _$LocationRequestOptionsCopyWithImpl;
@useResult
$Res call({
 bool highAccuracy, Duration timeout, Duration interval, double minDistanceMeters
});




}
/// @nodoc
class _$LocationRequestOptionsCopyWithImpl<$Res>
    implements $LocationRequestOptionsCopyWith<$Res> {
  _$LocationRequestOptionsCopyWithImpl(this._self, this._then);

  final LocationRequestOptions _self;
  final $Res Function(LocationRequestOptions) _then;

/// Create a copy of LocationRequestOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? highAccuracy = null,Object? timeout = null,Object? interval = null,Object? minDistanceMeters = null,}) {
  return _then(LocationRequestOptions(
highAccuracy: null == highAccuracy ? _self.highAccuracy : highAccuracy // ignore: cast_nullable_to_non_nullable
as bool,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as Duration,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as Duration,minDistanceMeters: null == minDistanceMeters ? _self.minDistanceMeters : minDistanceMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationRequestOptions].
extension LocationRequestOptionsPatterns on LocationRequestOptions {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationRequestOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationRequestOptions() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationRequestOptions value)  $default,){
final _that = this;
switch (_that) {
case _LocationRequestOptions():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationRequestOptions value)?  $default,){
final _that = this;
switch (_that) {
case _LocationRequestOptions() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool highAccuracy,  Duration timeout,  Duration interval,  double minDistanceMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationRequestOptions() when $default != null:
return $default(_that.highAccuracy,_that.timeout,_that.interval,_that.minDistanceMeters);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool highAccuracy,  Duration timeout,  Duration interval,  double minDistanceMeters)  $default,) {final _that = this;
switch (_that) {
case _LocationRequestOptions():
return $default(_that.highAccuracy,_that.timeout,_that.interval,_that.minDistanceMeters);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool highAccuracy,  Duration timeout,  Duration interval,  double minDistanceMeters)?  $default,) {final _that = this;
switch (_that) {
case _LocationRequestOptions() when $default != null:
return $default(_that.highAccuracy,_that.timeout,_that.interval,_that.minDistanceMeters);case _:
  return null;

}
}

}

/// @nodoc


class _LocationRequestOptions implements LocationRequestOptions {
  const _LocationRequestOptions({this.highAccuracy = true, this.timeout = const Duration(seconds: 15), this.interval = const Duration(seconds: 1), this.minDistanceMeters = 0.0});
  

@override@JsonKey() final  bool highAccuracy;
@override@JsonKey() final  Duration timeout;
@override@JsonKey() final  Duration interval;
@override@JsonKey() final  double minDistanceMeters;

/// Create a copy of LocationRequestOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationRequestOptionsCopyWith<_LocationRequestOptions> get copyWith => __$LocationRequestOptionsCopyWithImpl<_LocationRequestOptions>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationRequestOptions&&(identical(other.highAccuracy, highAccuracy) || other.highAccuracy == highAccuracy)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.minDistanceMeters, minDistanceMeters) || other.minDistanceMeters == minDistanceMeters));
}


@override
int get hashCode {
    return Object.hash(runtimeType,highAccuracy,timeout,interval,minDistanceMeters);
}

@override
String toString() {
    return 'LocationRequestOptions(highAccuracy: $highAccuracy, timeout: $timeout, interval: $interval, minDistanceMeters: $minDistanceMeters)';
}


}

/// @nodoc
abstract mixin class _$LocationRequestOptionsCopyWith<$Res> implements $LocationRequestOptionsCopyWith<$Res> {
  factory _$LocationRequestOptionsCopyWith(_LocationRequestOptions value, $Res Function(_LocationRequestOptions) _then) = __$LocationRequestOptionsCopyWithImpl;
@override @useResult
$Res call({
 bool highAccuracy, Duration timeout, Duration interval, double minDistanceMeters
});




}
/// @nodoc
class __$LocationRequestOptionsCopyWithImpl<$Res>
    implements _$LocationRequestOptionsCopyWith<$Res> {
  __$LocationRequestOptionsCopyWithImpl(this._self, this._then);

  final _LocationRequestOptions _self;
  final $Res Function(_LocationRequestOptions) _then;

/// Create a copy of LocationRequestOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? highAccuracy = null,Object? timeout = null,Object? interval = null,Object? minDistanceMeters = null,}) {
  return _then(_LocationRequestOptions(
highAccuracy: null == highAccuracy ? _self.highAccuracy : highAccuracy // ignore: cast_nullable_to_non_nullable
as bool,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as Duration,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as Duration,minDistanceMeters: null == minDistanceMeters ? _self.minDistanceMeters : minDistanceMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
