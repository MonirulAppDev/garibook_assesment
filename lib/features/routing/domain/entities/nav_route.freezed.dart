// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nav_route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NavRoute {

 GeoPoint get origin; GeoPoint get destination; List<GeoPoint> get points; double get distanceMeters; double get durationSeconds;
/// Create a copy of NavRoute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavRouteCopyWith<NavRoute> get copyWith => _$NavRouteCopyWithImpl<NavRoute>(this as NavRoute, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NavRoute;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavRoute&&(identical(other.origin, _this.origin) || other.origin == _this.origin)&&(identical(other.destination, _this.destination) || other.destination == _this.destination)&&const DeepCollectionEquality().equals(other.points, _this.points)&&(identical(other.distanceMeters, _this.distanceMeters) || other.distanceMeters == _this.distanceMeters)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds));
}


@override
int get hashCode {
  final _this = this as NavRoute;
  return Object.hash(runtimeType,_this.origin,_this.destination,const DeepCollectionEquality().hash(_this.points),_this.distanceMeters,_this.durationSeconds);
}

@override
String toString() {
  final _this = this as NavRoute;
  return 'NavRoute(origin: ${_this.origin}, destination: ${_this.destination}, points: ${_this.points}, distanceMeters: ${_this.distanceMeters}, durationSeconds: ${_this.durationSeconds})';
}


}

/// @nodoc
abstract mixin class $NavRouteCopyWith<$Res>  {
  factory $NavRouteCopyWith(NavRoute value, $Res Function(NavRoute) _then) = _$NavRouteCopyWithImpl;
@useResult
$Res call({
 GeoPoint origin, GeoPoint destination, List<GeoPoint> points, double distanceMeters, double durationSeconds
});


$GeoPointCopyWith<$Res> get origin;$GeoPointCopyWith<$Res> get destination;

}
/// @nodoc
class _$NavRouteCopyWithImpl<$Res>
    implements $NavRouteCopyWith<$Res> {
  _$NavRouteCopyWithImpl(this._self, this._then);

  final NavRoute _self;
  final $Res Function(NavRoute) _then;

/// Create a copy of NavRoute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? origin = null,Object? destination = null,Object? points = null,Object? distanceMeters = null,Object? durationSeconds = null,}) {
  return _then(NavRoute(
origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as GeoPoint,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as GeoPoint,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of NavRoute
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get origin {
  
  return $GeoPointCopyWith<$Res>(_self.origin, (value) {
    return _then(_self.copyWith(origin: value));
  });
}/// Create a copy of NavRoute
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get destination {
  
  return $GeoPointCopyWith<$Res>(_self.destination, (value) {
    return _then(_self.copyWith(destination: value));
  });
}
}


/// Adds pattern-matching-related methods to [NavRoute].
extension NavRoutePatterns on NavRoute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavRoute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavRoute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavRoute value)  $default,){
final _that = this;
switch (_that) {
case _NavRoute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavRoute value)?  $default,){
final _that = this;
switch (_that) {
case _NavRoute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GeoPoint origin,  GeoPoint destination,  List<GeoPoint> points,  double distanceMeters,  double durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavRoute() when $default != null:
return $default(_that.origin,_that.destination,_that.points,_that.distanceMeters,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GeoPoint origin,  GeoPoint destination,  List<GeoPoint> points,  double distanceMeters,  double durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _NavRoute():
return $default(_that.origin,_that.destination,_that.points,_that.distanceMeters,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GeoPoint origin,  GeoPoint destination,  List<GeoPoint> points,  double distanceMeters,  double durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _NavRoute() when $default != null:
return $default(_that.origin,_that.destination,_that.points,_that.distanceMeters,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc


class _NavRoute extends NavRoute {
  const _NavRoute({required this.origin, required this.destination, required  List<GeoPoint> points, required this.distanceMeters, required this.durationSeconds}): _points = points,super._();
  

@override final  GeoPoint origin;
@override final  GeoPoint destination;
 final  List<GeoPoint> _points;
@override List<GeoPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override final  double distanceMeters;
@override final  double durationSeconds;

/// Create a copy of NavRoute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavRouteCopyWith<_NavRoute> get copyWith => __$NavRouteCopyWithImpl<_NavRoute>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavRoute&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&const DeepCollectionEquality().equals(other.points, _points)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}


@override
int get hashCode {
    return Object.hash(runtimeType,origin,destination,const DeepCollectionEquality().hash(_points),distanceMeters,durationSeconds);
}

@override
String toString() {
    return 'NavRoute(origin: $origin, destination: $destination, points: $points, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$NavRouteCopyWith<$Res> implements $NavRouteCopyWith<$Res> {
  factory _$NavRouteCopyWith(_NavRoute value, $Res Function(_NavRoute) _then) = __$NavRouteCopyWithImpl;
@override @useResult
$Res call({
 GeoPoint origin, GeoPoint destination, List<GeoPoint> points, double distanceMeters, double durationSeconds
});


@override $GeoPointCopyWith<$Res> get origin;@override $GeoPointCopyWith<$Res> get destination;

}
/// @nodoc
class __$NavRouteCopyWithImpl<$Res>
    implements _$NavRouteCopyWith<$Res> {
  __$NavRouteCopyWithImpl(this._self, this._then);

  final _NavRoute _self;
  final $Res Function(_NavRoute) _then;

/// Create a copy of NavRoute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? origin = null,Object? destination = null,Object? points = null,Object? distanceMeters = null,Object? durationSeconds = null,}) {
  return _then(_NavRoute(
origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as GeoPoint,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as GeoPoint,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of NavRoute
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get origin {
  
  return $GeoPointCopyWith<$Res>(_self.origin, (value) {
    return _then(_self.copyWith(origin: value));
  });
}/// Create a copy of NavRoute
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get destination {
  
  return $GeoPointCopyWith<$Res>(_self.destination, (value) {
    return _then(_self.copyWith(destination: value));
  });
}
}

// dart format on
