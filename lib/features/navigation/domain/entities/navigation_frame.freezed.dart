// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NavigationFrame {

 GeoPoint get position; double get bearingDegrees; double get travelledMeters; double get remainingMeters; Duration get remainingTime; NavigationStatus get status; SpeedMultiplier get speed;
/// Create a copy of NavigationFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationFrameCopyWith<NavigationFrame> get copyWith => _$NavigationFrameCopyWithImpl<NavigationFrame>(this as NavigationFrame, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NavigationFrame;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationFrame&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.bearingDegrees, _this.bearingDegrees) || other.bearingDegrees == _this.bearingDegrees)&&(identical(other.travelledMeters, _this.travelledMeters) || other.travelledMeters == _this.travelledMeters)&&(identical(other.remainingMeters, _this.remainingMeters) || other.remainingMeters == _this.remainingMeters)&&(identical(other.remainingTime, _this.remainingTime) || other.remainingTime == _this.remainingTime)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.speed, _this.speed) || other.speed == _this.speed));
}


@override
int get hashCode {
  final _this = this as NavigationFrame;
  return Object.hash(runtimeType,_this.position,_this.bearingDegrees,_this.travelledMeters,_this.remainingMeters,_this.remainingTime,_this.status,_this.speed);
}

@override
String toString() {
  final _this = this as NavigationFrame;
  return 'NavigationFrame(position: ${_this.position}, bearingDegrees: ${_this.bearingDegrees}, travelledMeters: ${_this.travelledMeters}, remainingMeters: ${_this.remainingMeters}, remainingTime: ${_this.remainingTime}, status: ${_this.status}, speed: ${_this.speed})';
}


}

/// @nodoc
abstract mixin class $NavigationFrameCopyWith<$Res>  {
  factory $NavigationFrameCopyWith(NavigationFrame value, $Res Function(NavigationFrame) _then) = _$NavigationFrameCopyWithImpl;
@useResult
$Res call({
 GeoPoint position, double bearingDegrees, double travelledMeters, double remainingMeters, Duration remainingTime, NavigationStatus status, SpeedMultiplier speed
});


$GeoPointCopyWith<$Res> get position;

}
/// @nodoc
class _$NavigationFrameCopyWithImpl<$Res>
    implements $NavigationFrameCopyWith<$Res> {
  _$NavigationFrameCopyWithImpl(this._self, this._then);

  final NavigationFrame _self;
  final $Res Function(NavigationFrame) _then;

/// Create a copy of NavigationFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? bearingDegrees = null,Object? travelledMeters = null,Object? remainingMeters = null,Object? remainingTime = null,Object? status = null,Object? speed = null,}) {
  return _then(NavigationFrame(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as GeoPoint,bearingDegrees: null == bearingDegrees ? _self.bearingDegrees : bearingDegrees // ignore: cast_nullable_to_non_nullable
as double,travelledMeters: null == travelledMeters ? _self.travelledMeters : travelledMeters // ignore: cast_nullable_to_non_nullable
as double,remainingMeters: null == remainingMeters ? _self.remainingMeters : remainingMeters // ignore: cast_nullable_to_non_nullable
as double,remainingTime: null == remainingTime ? _self.remainingTime : remainingTime // ignore: cast_nullable_to_non_nullable
as Duration,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NavigationStatus,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as SpeedMultiplier,
  ));
}
/// Create a copy of NavigationFrame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get position {
  
  return $GeoPointCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// Adds pattern-matching-related methods to [NavigationFrame].
extension NavigationFramePatterns on NavigationFrame {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigationFrame value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigationFrame() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigationFrame value)  $default,){
final _that = this;
switch (_that) {
case _NavigationFrame():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavigationFrame value)?  $default,){
final _that = this;
switch (_that) {
case _NavigationFrame() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GeoPoint position,  double bearingDegrees,  double travelledMeters,  double remainingMeters,  Duration remainingTime,  NavigationStatus status,  SpeedMultiplier speed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavigationFrame() when $default != null:
return $default(_that.position,_that.bearingDegrees,_that.travelledMeters,_that.remainingMeters,_that.remainingTime,_that.status,_that.speed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GeoPoint position,  double bearingDegrees,  double travelledMeters,  double remainingMeters,  Duration remainingTime,  NavigationStatus status,  SpeedMultiplier speed)  $default,) {final _that = this;
switch (_that) {
case _NavigationFrame():
return $default(_that.position,_that.bearingDegrees,_that.travelledMeters,_that.remainingMeters,_that.remainingTime,_that.status,_that.speed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GeoPoint position,  double bearingDegrees,  double travelledMeters,  double remainingMeters,  Duration remainingTime,  NavigationStatus status,  SpeedMultiplier speed)?  $default,) {final _that = this;
switch (_that) {
case _NavigationFrame() when $default != null:
return $default(_that.position,_that.bearingDegrees,_that.travelledMeters,_that.remainingMeters,_that.remainingTime,_that.status,_that.speed);case _:
  return null;

}
}

}

/// @nodoc


class _NavigationFrame extends NavigationFrame {
  const _NavigationFrame({required this.position, required this.bearingDegrees, required this.travelledMeters, required this.remainingMeters, required this.remainingTime, required this.status, required this.speed}): super._();
  

@override final  GeoPoint position;
@override final  double bearingDegrees;
@override final  double travelledMeters;
@override final  double remainingMeters;
@override final  Duration remainingTime;
@override final  NavigationStatus status;
@override final  SpeedMultiplier speed;

/// Create a copy of NavigationFrame
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigationFrameCopyWith<_NavigationFrame> get copyWith => __$NavigationFrameCopyWithImpl<_NavigationFrame>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigationFrame&&(identical(other.position, position) || other.position == position)&&(identical(other.bearingDegrees, bearingDegrees) || other.bearingDegrees == bearingDegrees)&&(identical(other.travelledMeters, travelledMeters) || other.travelledMeters == travelledMeters)&&(identical(other.remainingMeters, remainingMeters) || other.remainingMeters == remainingMeters)&&(identical(other.remainingTime, remainingTime) || other.remainingTime == remainingTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.speed, speed) || other.speed == speed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,position,bearingDegrees,travelledMeters,remainingMeters,remainingTime,status,speed);
}

@override
String toString() {
    return 'NavigationFrame(position: $position, bearingDegrees: $bearingDegrees, travelledMeters: $travelledMeters, remainingMeters: $remainingMeters, remainingTime: $remainingTime, status: $status, speed: $speed)';
}


}

/// @nodoc
abstract mixin class _$NavigationFrameCopyWith<$Res> implements $NavigationFrameCopyWith<$Res> {
  factory _$NavigationFrameCopyWith(_NavigationFrame value, $Res Function(_NavigationFrame) _then) = __$NavigationFrameCopyWithImpl;
@override @useResult
$Res call({
 GeoPoint position, double bearingDegrees, double travelledMeters, double remainingMeters, Duration remainingTime, NavigationStatus status, SpeedMultiplier speed
});


@override $GeoPointCopyWith<$Res> get position;

}
/// @nodoc
class __$NavigationFrameCopyWithImpl<$Res>
    implements _$NavigationFrameCopyWith<$Res> {
  __$NavigationFrameCopyWithImpl(this._self, this._then);

  final _NavigationFrame _self;
  final $Res Function(_NavigationFrame) _then;

/// Create a copy of NavigationFrame
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? bearingDegrees = null,Object? travelledMeters = null,Object? remainingMeters = null,Object? remainingTime = null,Object? status = null,Object? speed = null,}) {
  return _then(_NavigationFrame(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as GeoPoint,bearingDegrees: null == bearingDegrees ? _self.bearingDegrees : bearingDegrees // ignore: cast_nullable_to_non_nullable
as double,travelledMeters: null == travelledMeters ? _self.travelledMeters : travelledMeters // ignore: cast_nullable_to_non_nullable
as double,remainingMeters: null == remainingMeters ? _self.remainingMeters : remainingMeters // ignore: cast_nullable_to_non_nullable
as double,remainingTime: null == remainingTime ? _self.remainingTime : remainingTime // ignore: cast_nullable_to_non_nullable
as Duration,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NavigationStatus,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as SpeedMultiplier,
  ));
}

/// Create a copy of NavigationFrame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get position {
  
  return $GeoPointCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}

// dart format on
