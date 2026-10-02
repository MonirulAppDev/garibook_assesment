// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'osrm_route_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OsrmRouteResponse {

 String get code; String? get message; List<OsrmRouteDto> get routes;
/// Create a copy of OsrmRouteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OsrmRouteResponseCopyWith<OsrmRouteResponse> get copyWith => _$OsrmRouteResponseCopyWithImpl<OsrmRouteResponse>(this as OsrmRouteResponse, _$identity);

  /// Serializes this OsrmRouteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OsrmRouteResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OsrmRouteResponse&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.routes, _this.routes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OsrmRouteResponse;
  return Object.hash(runtimeType,_this.code,_this.message,const DeepCollectionEquality().hash(_this.routes));
}

@override
String toString() {
  final _this = this as OsrmRouteResponse;
  return 'OsrmRouteResponse(code: ${_this.code}, message: ${_this.message}, routes: ${_this.routes})';
}


}

/// @nodoc
abstract mixin class $OsrmRouteResponseCopyWith<$Res>  {
  factory $OsrmRouteResponseCopyWith(OsrmRouteResponse value, $Res Function(OsrmRouteResponse) _then) = _$OsrmRouteResponseCopyWithImpl;
@useResult
$Res call({
 String code, String? message, List<OsrmRouteDto> routes
});




}
/// @nodoc
class _$OsrmRouteResponseCopyWithImpl<$Res>
    implements $OsrmRouteResponseCopyWith<$Res> {
  _$OsrmRouteResponseCopyWithImpl(this._self, this._then);

  final OsrmRouteResponse _self;
  final $Res Function(OsrmRouteResponse) _then;

/// Create a copy of OsrmRouteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = freezed,Object? routes = null,}) {
  return _then(OsrmRouteResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,routes: null == routes ? _self.routes : routes // ignore: cast_nullable_to_non_nullable
as List<OsrmRouteDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [OsrmRouteResponse].
extension OsrmRouteResponsePatterns on OsrmRouteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OsrmRouteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OsrmRouteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OsrmRouteResponse value)  $default,){
final _that = this;
switch (_that) {
case _OsrmRouteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OsrmRouteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _OsrmRouteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String? message,  List<OsrmRouteDto> routes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OsrmRouteResponse() when $default != null:
return $default(_that.code,_that.message,_that.routes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String? message,  List<OsrmRouteDto> routes)  $default,) {final _that = this;
switch (_that) {
case _OsrmRouteResponse():
return $default(_that.code,_that.message,_that.routes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String? message,  List<OsrmRouteDto> routes)?  $default,) {final _that = this;
switch (_that) {
case _OsrmRouteResponse() when $default != null:
return $default(_that.code,_that.message,_that.routes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OsrmRouteResponse implements OsrmRouteResponse {
  const _OsrmRouteResponse({required this.code, this.message,  List<OsrmRouteDto> routes = const <OsrmRouteDto>[]}): _routes = routes;
  factory _OsrmRouteResponse.fromJson(Map<String, dynamic> json) => _$OsrmRouteResponseFromJson(json);

@override final  String code;
@override final  String? message;
 final  List<OsrmRouteDto> _routes;
@override@JsonKey() List<OsrmRouteDto> get routes {
  if (_routes is EqualUnmodifiableListView) return _routes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routes);
}


/// Create a copy of OsrmRouteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OsrmRouteResponseCopyWith<_OsrmRouteResponse> get copyWith => __$OsrmRouteResponseCopyWithImpl<_OsrmRouteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OsrmRouteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OsrmRouteResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.routes, _routes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,message,const DeepCollectionEquality().hash(_routes));
}

@override
String toString() {
    return 'OsrmRouteResponse(code: $code, message: $message, routes: $routes)';
}


}

/// @nodoc
abstract mixin class _$OsrmRouteResponseCopyWith<$Res> implements $OsrmRouteResponseCopyWith<$Res> {
  factory _$OsrmRouteResponseCopyWith(_OsrmRouteResponse value, $Res Function(_OsrmRouteResponse) _then) = __$OsrmRouteResponseCopyWithImpl;
@override @useResult
$Res call({
 String code, String? message, List<OsrmRouteDto> routes
});




}
/// @nodoc
class __$OsrmRouteResponseCopyWithImpl<$Res>
    implements _$OsrmRouteResponseCopyWith<$Res> {
  __$OsrmRouteResponseCopyWithImpl(this._self, this._then);

  final _OsrmRouteResponse _self;
  final $Res Function(_OsrmRouteResponse) _then;

/// Create a copy of OsrmRouteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = freezed,Object? routes = null,}) {
  return _then(_OsrmRouteResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,routes: null == routes ? _self._routes : routes // ignore: cast_nullable_to_non_nullable
as List<OsrmRouteDto>,
  ));
}


}


/// @nodoc
mixin _$OsrmRouteDto {

 double get distance; double get duration; String get geometry;
/// Create a copy of OsrmRouteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OsrmRouteDtoCopyWith<OsrmRouteDto> get copyWith => _$OsrmRouteDtoCopyWithImpl<OsrmRouteDto>(this as OsrmRouteDto, _$identity);

  /// Serializes this OsrmRouteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OsrmRouteDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OsrmRouteDto&&(identical(other.distance, _this.distance) || other.distance == _this.distance)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.geometry, _this.geometry) || other.geometry == _this.geometry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OsrmRouteDto;
  return Object.hash(runtimeType,_this.distance,_this.duration,_this.geometry);
}

@override
String toString() {
  final _this = this as OsrmRouteDto;
  return 'OsrmRouteDto(distance: ${_this.distance}, duration: ${_this.duration}, geometry: ${_this.geometry})';
}


}

/// @nodoc
abstract mixin class $OsrmRouteDtoCopyWith<$Res>  {
  factory $OsrmRouteDtoCopyWith(OsrmRouteDto value, $Res Function(OsrmRouteDto) _then) = _$OsrmRouteDtoCopyWithImpl;
@useResult
$Res call({
 double distance, double duration, String geometry
});




}
/// @nodoc
class _$OsrmRouteDtoCopyWithImpl<$Res>
    implements $OsrmRouteDtoCopyWith<$Res> {
  _$OsrmRouteDtoCopyWithImpl(this._self, this._then);

  final OsrmRouteDto _self;
  final $Res Function(OsrmRouteDto) _then;

/// Create a copy of OsrmRouteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? distance = null,Object? duration = null,Object? geometry = null,}) {
  return _then(OsrmRouteDto(
distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as double,geometry: null == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OsrmRouteDto].
extension OsrmRouteDtoPatterns on OsrmRouteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OsrmRouteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OsrmRouteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OsrmRouteDto value)  $default,){
final _that = this;
switch (_that) {
case _OsrmRouteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OsrmRouteDto value)?  $default,){
final _that = this;
switch (_that) {
case _OsrmRouteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double distance,  double duration,  String geometry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OsrmRouteDto() when $default != null:
return $default(_that.distance,_that.duration,_that.geometry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double distance,  double duration,  String geometry)  $default,) {final _that = this;
switch (_that) {
case _OsrmRouteDto():
return $default(_that.distance,_that.duration,_that.geometry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double distance,  double duration,  String geometry)?  $default,) {final _that = this;
switch (_that) {
case _OsrmRouteDto() when $default != null:
return $default(_that.distance,_that.duration,_that.geometry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OsrmRouteDto implements OsrmRouteDto {
  const _OsrmRouteDto({required this.distance, required this.duration, required this.geometry});
  factory _OsrmRouteDto.fromJson(Map<String, dynamic> json) => _$OsrmRouteDtoFromJson(json);

@override final  double distance;
@override final  double duration;
@override final  String geometry;

/// Create a copy of OsrmRouteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OsrmRouteDtoCopyWith<_OsrmRouteDto> get copyWith => __$OsrmRouteDtoCopyWithImpl<_OsrmRouteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OsrmRouteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OsrmRouteDto&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.geometry, geometry) || other.geometry == geometry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,distance,duration,geometry);
}

@override
String toString() {
    return 'OsrmRouteDto(distance: $distance, duration: $duration, geometry: $geometry)';
}


}

/// @nodoc
abstract mixin class _$OsrmRouteDtoCopyWith<$Res> implements $OsrmRouteDtoCopyWith<$Res> {
  factory _$OsrmRouteDtoCopyWith(_OsrmRouteDto value, $Res Function(_OsrmRouteDto) _then) = __$OsrmRouteDtoCopyWithImpl;
@override @useResult
$Res call({
 double distance, double duration, String geometry
});




}
/// @nodoc
class __$OsrmRouteDtoCopyWithImpl<$Res>
    implements _$OsrmRouteDtoCopyWith<$Res> {
  __$OsrmRouteDtoCopyWithImpl(this._self, this._then);

  final _OsrmRouteDto _self;
  final $Res Function(_OsrmRouteDto) _then;

/// Create a copy of OsrmRouteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? distance = null,Object? duration = null,Object? geometry = null,}) {
  return _then(_OsrmRouteDto(
distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as double,geometry: null == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
