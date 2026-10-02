// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_fix.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationFix {

 GeoPoint get position; double get accuracyMeters; DateTime get timestamp; double? get bearingDegrees; double? get speedMps; bool get isMock;
/// Create a copy of LocationFix
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationFixCopyWith<LocationFix> get copyWith => _$LocationFixCopyWithImpl<LocationFix>(this as LocationFix, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocationFix;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationFix&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.accuracyMeters, _this.accuracyMeters) || other.accuracyMeters == _this.accuracyMeters)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp)&&(identical(other.bearingDegrees, _this.bearingDegrees) || other.bearingDegrees == _this.bearingDegrees)&&(identical(other.speedMps, _this.speedMps) || other.speedMps == _this.speedMps)&&(identical(other.isMock, _this.isMock) || other.isMock == _this.isMock));
}


@override
int get hashCode {
  final _this = this as LocationFix;
  return Object.hash(runtimeType,_this.position,_this.accuracyMeters,_this.timestamp,_this.bearingDegrees,_this.speedMps,_this.isMock);
}

@override
String toString() {
  final _this = this as LocationFix;
  return 'LocationFix(position: ${_this.position}, accuracyMeters: ${_this.accuracyMeters}, timestamp: ${_this.timestamp}, bearingDegrees: ${_this.bearingDegrees}, speedMps: ${_this.speedMps}, isMock: ${_this.isMock})';
}


}

/// @nodoc
abstract mixin class $LocationFixCopyWith<$Res>  {
  factory $LocationFixCopyWith(LocationFix value, $Res Function(LocationFix) _then) = _$LocationFixCopyWithImpl;
@useResult
$Res call({
 GeoPoint position, double accuracyMeters, DateTime timestamp, double? bearingDegrees, double? speedMps, bool isMock
});


$GeoPointCopyWith<$Res> get position;

}
/// @nodoc
class _$LocationFixCopyWithImpl<$Res>
    implements $LocationFixCopyWith<$Res> {
  _$LocationFixCopyWithImpl(this._self, this._then);

  final LocationFix _self;
  final $Res Function(LocationFix) _then;

/// Create a copy of LocationFix
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? accuracyMeters = null,Object? timestamp = null,Object? bearingDegrees = freezed,Object? speedMps = freezed,Object? isMock = null,}) {
  return _then(LocationFix(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as GeoPoint,accuracyMeters: null == accuracyMeters ? _self.accuracyMeters : accuracyMeters // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,bearingDegrees: freezed == bearingDegrees ? _self.bearingDegrees : bearingDegrees // ignore: cast_nullable_to_non_nullable
as double?,speedMps: freezed == speedMps ? _self.speedMps : speedMps // ignore: cast_nullable_to_non_nullable
as double?,isMock: null == isMock ? _self.isMock : isMock // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of LocationFix
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get position {
  
  return $GeoPointCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocationFix].
extension LocationFixPatterns on LocationFix {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationFix value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationFix() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationFix value)  $default,){
final _that = this;
switch (_that) {
case _LocationFix():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationFix value)?  $default,){
final _that = this;
switch (_that) {
case _LocationFix() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GeoPoint position,  double accuracyMeters,  DateTime timestamp,  double? bearingDegrees,  double? speedMps,  bool isMock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationFix() when $default != null:
return $default(_that.position,_that.accuracyMeters,_that.timestamp,_that.bearingDegrees,_that.speedMps,_that.isMock);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GeoPoint position,  double accuracyMeters,  DateTime timestamp,  double? bearingDegrees,  double? speedMps,  bool isMock)  $default,) {final _that = this;
switch (_that) {
case _LocationFix():
return $default(_that.position,_that.accuracyMeters,_that.timestamp,_that.bearingDegrees,_that.speedMps,_that.isMock);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GeoPoint position,  double accuracyMeters,  DateTime timestamp,  double? bearingDegrees,  double? speedMps,  bool isMock)?  $default,) {final _that = this;
switch (_that) {
case _LocationFix() when $default != null:
return $default(_that.position,_that.accuracyMeters,_that.timestamp,_that.bearingDegrees,_that.speedMps,_that.isMock);case _:
  return null;

}
}

}

/// @nodoc


class _LocationFix implements LocationFix {
  const _LocationFix({required this.position, required this.accuracyMeters, required this.timestamp, this.bearingDegrees, this.speedMps, this.isMock = false});
  

@override final  GeoPoint position;
@override final  double accuracyMeters;
@override final  DateTime timestamp;
@override final  double? bearingDegrees;
@override final  double? speedMps;
@override@JsonKey() final  bool isMock;

/// Create a copy of LocationFix
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationFixCopyWith<_LocationFix> get copyWith => __$LocationFixCopyWithImpl<_LocationFix>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationFix&&(identical(other.position, position) || other.position == position)&&(identical(other.accuracyMeters, accuracyMeters) || other.accuracyMeters == accuracyMeters)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.bearingDegrees, bearingDegrees) || other.bearingDegrees == bearingDegrees)&&(identical(other.speedMps, speedMps) || other.speedMps == speedMps)&&(identical(other.isMock, isMock) || other.isMock == isMock));
}


@override
int get hashCode {
    return Object.hash(runtimeType,position,accuracyMeters,timestamp,bearingDegrees,speedMps,isMock);
}

@override
String toString() {
    return 'LocationFix(position: $position, accuracyMeters: $accuracyMeters, timestamp: $timestamp, bearingDegrees: $bearingDegrees, speedMps: $speedMps, isMock: $isMock)';
}


}

/// @nodoc
abstract mixin class _$LocationFixCopyWith<$Res> implements $LocationFixCopyWith<$Res> {
  factory _$LocationFixCopyWith(_LocationFix value, $Res Function(_LocationFix) _then) = __$LocationFixCopyWithImpl;
@override @useResult
$Res call({
 GeoPoint position, double accuracyMeters, DateTime timestamp, double? bearingDegrees, double? speedMps, bool isMock
});


@override $GeoPointCopyWith<$Res> get position;

}
/// @nodoc
class __$LocationFixCopyWithImpl<$Res>
    implements _$LocationFixCopyWith<$Res> {
  __$LocationFixCopyWithImpl(this._self, this._then);

  final _LocationFix _self;
  final $Res Function(_LocationFix) _then;

/// Create a copy of LocationFix
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? accuracyMeters = null,Object? timestamp = null,Object? bearingDegrees = freezed,Object? speedMps = freezed,Object? isMock = null,}) {
  return _then(_LocationFix(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as GeoPoint,accuracyMeters: null == accuracyMeters ? _self.accuracyMeters : accuracyMeters // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,bearingDegrees: freezed == bearingDegrees ? _self.bearingDegrees : bearingDegrees // ignore: cast_nullable_to_non_nullable
as double?,speedMps: freezed == speedMps ? _self.speedMps : speedMps // ignore: cast_nullable_to_non_nullable
as double?,isMock: null == isMock ? _self.isMock : isMock // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LocationFix
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
