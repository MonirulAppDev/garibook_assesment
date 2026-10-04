// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routing_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoutingState {

 GeoPoint? get manualOrigin; GeoPoint? get deviceLocation; GeoPoint? get destination; RouteStatus get status; bool get isSlow; NavRoute? get route; RoutingFailure? get failure;
/// Create a copy of RoutingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutingStateCopyWith<RoutingState> get copyWith => _$RoutingStateCopyWithImpl<RoutingState>(this as RoutingState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutingState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutingState&&(identical(other.manualOrigin, _this.manualOrigin) || other.manualOrigin == _this.manualOrigin)&&(identical(other.deviceLocation, _this.deviceLocation) || other.deviceLocation == _this.deviceLocation)&&(identical(other.destination, _this.destination) || other.destination == _this.destination)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.isSlow, _this.isSlow) || other.isSlow == _this.isSlow)&&(identical(other.route, _this.route) || other.route == _this.route)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as RoutingState;
  return Object.hash(runtimeType,_this.manualOrigin,_this.deviceLocation,_this.destination,_this.status,_this.isSlow,_this.route,_this.failure);
}

@override
String toString() {
  final _this = this as RoutingState;
  return 'RoutingState(manualOrigin: ${_this.manualOrigin}, deviceLocation: ${_this.deviceLocation}, destination: ${_this.destination}, status: ${_this.status}, isSlow: ${_this.isSlow}, route: ${_this.route}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $RoutingStateCopyWith<$Res>  {
  factory $RoutingStateCopyWith(RoutingState value, $Res Function(RoutingState) _then) = _$RoutingStateCopyWithImpl;
@useResult
$Res call({
 GeoPoint? manualOrigin, GeoPoint? deviceLocation, GeoPoint? destination, RouteStatus status, bool isSlow, NavRoute? route, RoutingFailure? failure
});


$GeoPointCopyWith<$Res>? get manualOrigin;$GeoPointCopyWith<$Res>? get deviceLocation;$GeoPointCopyWith<$Res>? get destination;$NavRouteCopyWith<$Res>? get route;

}
/// @nodoc
class _$RoutingStateCopyWithImpl<$Res>
    implements $RoutingStateCopyWith<$Res> {
  _$RoutingStateCopyWithImpl(this._self, this._then);

  final RoutingState _self;
  final $Res Function(RoutingState) _then;

/// Create a copy of RoutingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? manualOrigin = freezed,Object? deviceLocation = freezed,Object? destination = freezed,Object? status = null,Object? isSlow = null,Object? route = freezed,Object? failure = freezed,}) {
  return _then(RoutingState(
manualOrigin: freezed == manualOrigin ? _self.manualOrigin : manualOrigin // ignore: cast_nullable_to_non_nullable
as GeoPoint?,deviceLocation: freezed == deviceLocation ? _self.deviceLocation : deviceLocation // ignore: cast_nullable_to_non_nullable
as GeoPoint?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as GeoPoint?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RouteStatus,isSlow: null == isSlow ? _self.isSlow : isSlow // ignore: cast_nullable_to_non_nullable
as bool,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as NavRoute?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as RoutingFailure?,
  ));
}
/// Create a copy of RoutingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get manualOrigin {
    if (_self.manualOrigin == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.manualOrigin!, (value) {
    return _then(_self.copyWith(manualOrigin: value));
  });
}/// Create a copy of RoutingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get deviceLocation {
    if (_self.deviceLocation == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.deviceLocation!, (value) {
    return _then(_self.copyWith(deviceLocation: value));
  });
}/// Create a copy of RoutingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get destination {
    if (_self.destination == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.destination!, (value) {
    return _then(_self.copyWith(destination: value));
  });
}/// Create a copy of RoutingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NavRouteCopyWith<$Res>? get route {
    if (_self.route == null) {
    return null;
  }

  return $NavRouteCopyWith<$Res>(_self.route!, (value) {
    return _then(_self.copyWith(route: value));
  });
}
}


/// Adds pattern-matching-related methods to [RoutingState].
extension RoutingStatePatterns on RoutingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutingState value)  $default,){
final _that = this;
switch (_that) {
case _RoutingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutingState value)?  $default,){
final _that = this;
switch (_that) {
case _RoutingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GeoPoint? manualOrigin,  GeoPoint? deviceLocation,  GeoPoint? destination,  RouteStatus status,  bool isSlow,  NavRoute? route,  RoutingFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutingState() when $default != null:
return $default(_that.manualOrigin,_that.deviceLocation,_that.destination,_that.status,_that.isSlow,_that.route,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GeoPoint? manualOrigin,  GeoPoint? deviceLocation,  GeoPoint? destination,  RouteStatus status,  bool isSlow,  NavRoute? route,  RoutingFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _RoutingState():
return $default(_that.manualOrigin,_that.deviceLocation,_that.destination,_that.status,_that.isSlow,_that.route,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GeoPoint? manualOrigin,  GeoPoint? deviceLocation,  GeoPoint? destination,  RouteStatus status,  bool isSlow,  NavRoute? route,  RoutingFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _RoutingState() when $default != null:
return $default(_that.manualOrigin,_that.deviceLocation,_that.destination,_that.status,_that.isSlow,_that.route,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _RoutingState extends RoutingState {
  const _RoutingState({this.manualOrigin, this.deviceLocation, this.destination, this.status = RouteStatus.idle, this.isSlow = false, this.route, this.failure}): super._();
  

@override final  GeoPoint? manualOrigin;
@override final  GeoPoint? deviceLocation;
@override final  GeoPoint? destination;
@override@JsonKey() final  RouteStatus status;
@override@JsonKey() final  bool isSlow;
@override final  NavRoute? route;
@override final  RoutingFailure? failure;

/// Create a copy of RoutingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutingStateCopyWith<_RoutingState> get copyWith => __$RoutingStateCopyWithImpl<_RoutingState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutingState&&(identical(other.manualOrigin, manualOrigin) || other.manualOrigin == manualOrigin)&&(identical(other.deviceLocation, deviceLocation) || other.deviceLocation == deviceLocation)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.status, status) || other.status == status)&&(identical(other.isSlow, isSlow) || other.isSlow == isSlow)&&(identical(other.route, route) || other.route == route)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,manualOrigin,deviceLocation,destination,status,isSlow,route,failure);
}

@override
String toString() {
    return 'RoutingState(manualOrigin: $manualOrigin, deviceLocation: $deviceLocation, destination: $destination, status: $status, isSlow: $isSlow, route: $route, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$RoutingStateCopyWith<$Res> implements $RoutingStateCopyWith<$Res> {
  factory _$RoutingStateCopyWith(_RoutingState value, $Res Function(_RoutingState) _then) = __$RoutingStateCopyWithImpl;
@override @useResult
$Res call({
 GeoPoint? manualOrigin, GeoPoint? deviceLocation, GeoPoint? destination, RouteStatus status, bool isSlow, NavRoute? route, RoutingFailure? failure
});


@override $GeoPointCopyWith<$Res>? get manualOrigin;@override $GeoPointCopyWith<$Res>? get deviceLocation;@override $GeoPointCopyWith<$Res>? get destination;@override $NavRouteCopyWith<$Res>? get route;

}
/// @nodoc
class __$RoutingStateCopyWithImpl<$Res>
    implements _$RoutingStateCopyWith<$Res> {
  __$RoutingStateCopyWithImpl(this._self, this._then);

  final _RoutingState _self;
  final $Res Function(_RoutingState) _then;

/// Create a copy of RoutingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? manualOrigin = freezed,Object? deviceLocation = freezed,Object? destination = freezed,Object? status = null,Object? isSlow = null,Object? route = freezed,Object? failure = freezed,}) {
  return _then(_RoutingState(
manualOrigin: freezed == manualOrigin ? _self.manualOrigin : manualOrigin // ignore: cast_nullable_to_non_nullable
as GeoPoint?,deviceLocation: freezed == deviceLocation ? _self.deviceLocation : deviceLocation // ignore: cast_nullable_to_non_nullable
as GeoPoint?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as GeoPoint?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RouteStatus,isSlow: null == isSlow ? _self.isSlow : isSlow // ignore: cast_nullable_to_non_nullable
as bool,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as NavRoute?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as RoutingFailure?,
  ));
}

/// Create a copy of RoutingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get manualOrigin {
    if (_self.manualOrigin == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.manualOrigin!, (value) {
    return _then(_self.copyWith(manualOrigin: value));
  });
}/// Create a copy of RoutingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get deviceLocation {
    if (_self.deviceLocation == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.deviceLocation!, (value) {
    return _then(_self.copyWith(deviceLocation: value));
  });
}/// Create a copy of RoutingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get destination {
    if (_self.destination == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.destination!, (value) {
    return _then(_self.copyWith(destination: value));
  });
}/// Create a copy of RoutingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NavRouteCopyWith<$Res>? get route {
    if (_self.route == null) {
    return null;
  }

  return $NavRouteCopyWith<$Res>(_self.route!, (value) {
    return _then(_self.copyWith(route: value));
  });
}
}

// dart format on
