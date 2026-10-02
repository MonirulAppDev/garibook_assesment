// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_driving_route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RouteParams {

 GeoPoint get from; GeoPoint get to;
/// Create a copy of RouteParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteParamsCopyWith<RouteParams> get copyWith => _$RouteParamsCopyWithImpl<RouteParams>(this as RouteParams, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RouteParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteParams&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.to, _this.to) || other.to == _this.to));
}


@override
int get hashCode {
  final _this = this as RouteParams;
  return Object.hash(runtimeType,_this.from,_this.to);
}

@override
String toString() {
  final _this = this as RouteParams;
  return 'RouteParams(from: ${_this.from}, to: ${_this.to})';
}


}

/// @nodoc
abstract mixin class $RouteParamsCopyWith<$Res>  {
  factory $RouteParamsCopyWith(RouteParams value, $Res Function(RouteParams) _then) = _$RouteParamsCopyWithImpl;
@useResult
$Res call({
 GeoPoint from, GeoPoint to
});


$GeoPointCopyWith<$Res> get from;$GeoPointCopyWith<$Res> get to;

}
/// @nodoc
class _$RouteParamsCopyWithImpl<$Res>
    implements $RouteParamsCopyWith<$Res> {
  _$RouteParamsCopyWithImpl(this._self, this._then);

  final RouteParams _self;
  final $Res Function(RouteParams) _then;

/// Create a copy of RouteParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,}) {
  return _then(RouteParams(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as GeoPoint,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as GeoPoint,
  ));
}
/// Create a copy of RouteParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get from {
  
  return $GeoPointCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of RouteParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get to {
  
  return $GeoPointCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}


/// Adds pattern-matching-related methods to [RouteParams].
extension RouteParamsPatterns on RouteParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteParams value)  $default,){
final _that = this;
switch (_that) {
case _RouteParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteParams value)?  $default,){
final _that = this;
switch (_that) {
case _RouteParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GeoPoint from,  GeoPoint to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteParams() when $default != null:
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GeoPoint from,  GeoPoint to)  $default,) {final _that = this;
switch (_that) {
case _RouteParams():
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GeoPoint from,  GeoPoint to)?  $default,) {final _that = this;
switch (_that) {
case _RouteParams() when $default != null:
return $default(_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc


class _RouteParams implements RouteParams {
  const _RouteParams({required this.from, required this.to});
  

@override final  GeoPoint from;
@override final  GeoPoint to;

/// Create a copy of RouteParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteParamsCopyWith<_RouteParams> get copyWith => __$RouteParamsCopyWithImpl<_RouteParams>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteParams&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode {
    return Object.hash(runtimeType,from,to);
}

@override
String toString() {
    return 'RouteParams(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$RouteParamsCopyWith<$Res> implements $RouteParamsCopyWith<$Res> {
  factory _$RouteParamsCopyWith(_RouteParams value, $Res Function(_RouteParams) _then) = __$RouteParamsCopyWithImpl;
@override @useResult
$Res call({
 GeoPoint from, GeoPoint to
});


@override $GeoPointCopyWith<$Res> get from;@override $GeoPointCopyWith<$Res> get to;

}
/// @nodoc
class __$RouteParamsCopyWithImpl<$Res>
    implements _$RouteParamsCopyWith<$Res> {
  __$RouteParamsCopyWithImpl(this._self, this._then);

  final _RouteParams _self;
  final $Res Function(_RouteParams) _then;

/// Create a copy of RouteParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,}) {
  return _then(_RouteParams(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as GeoPoint,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as GeoPoint,
  ));
}

/// Create a copy of RouteParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get from {
  
  return $GeoPointCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of RouteParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get to {
  
  return $GeoPointCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}

// dart format on
