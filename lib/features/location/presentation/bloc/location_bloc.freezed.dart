// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationState {

 LocationStatus get status; LocationPermissionStatus? get permission; LocationFix? get fix; LocationFailure? get failure; bool get promptDismissed;
/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationStateCopyWith<LocationState> get copyWith => _$LocationStateCopyWithImpl<LocationState>(this as LocationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.permission, _this.permission) || other.permission == _this.permission)&&(identical(other.fix, _this.fix) || other.fix == _this.fix)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.promptDismissed, _this.promptDismissed) || other.promptDismissed == _this.promptDismissed));
}


@override
int get hashCode {
  final _this = this as LocationState;
  return Object.hash(runtimeType,_this.status,_this.permission,_this.fix,_this.failure,_this.promptDismissed);
}

@override
String toString() {
  final _this = this as LocationState;
  return 'LocationState(status: ${_this.status}, permission: ${_this.permission}, fix: ${_this.fix}, failure: ${_this.failure}, promptDismissed: ${_this.promptDismissed})';
}


}

/// @nodoc
abstract mixin class $LocationStateCopyWith<$Res>  {
  factory $LocationStateCopyWith(LocationState value, $Res Function(LocationState) _then) = _$LocationStateCopyWithImpl;
@useResult
$Res call({
 LocationStatus status, LocationPermissionStatus? permission, LocationFix? fix, LocationFailure? failure, bool promptDismissed
});


$LocationFixCopyWith<$Res>? get fix;

}
/// @nodoc
class _$LocationStateCopyWithImpl<$Res>
    implements $LocationStateCopyWith<$Res> {
  _$LocationStateCopyWithImpl(this._self, this._then);

  final LocationState _self;
  final $Res Function(LocationState) _then;

/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? permission = freezed,Object? fix = freezed,Object? failure = freezed,Object? promptDismissed = null,}) {
  return _then(LocationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LocationStatus,permission: freezed == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as LocationPermissionStatus?,fix: freezed == fix ? _self.fix : fix // ignore: cast_nullable_to_non_nullable
as LocationFix?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as LocationFailure?,promptDismissed: null == promptDismissed ? _self.promptDismissed : promptDismissed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationFixCopyWith<$Res>? get fix {
    if (_self.fix == null) {
    return null;
  }

  return $LocationFixCopyWith<$Res>(_self.fix!, (value) {
    return _then(_self.copyWith(fix: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocationState].
extension LocationStatePatterns on LocationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationState value)  $default,){
final _that = this;
switch (_that) {
case _LocationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocationStatus status,  LocationPermissionStatus? permission,  LocationFix? fix,  LocationFailure? failure,  bool promptDismissed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationState() when $default != null:
return $default(_that.status,_that.permission,_that.fix,_that.failure,_that.promptDismissed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocationStatus status,  LocationPermissionStatus? permission,  LocationFix? fix,  LocationFailure? failure,  bool promptDismissed)  $default,) {final _that = this;
switch (_that) {
case _LocationState():
return $default(_that.status,_that.permission,_that.fix,_that.failure,_that.promptDismissed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocationStatus status,  LocationPermissionStatus? permission,  LocationFix? fix,  LocationFailure? failure,  bool promptDismissed)?  $default,) {final _that = this;
switch (_that) {
case _LocationState() when $default != null:
return $default(_that.status,_that.permission,_that.fix,_that.failure,_that.promptDismissed);case _:
  return null;

}
}

}

/// @nodoc


class _LocationState extends LocationState {
  const _LocationState({this.status = LocationStatus.initial, this.permission, this.fix, this.failure, this.promptDismissed = false}): super._();
  

@override@JsonKey() final  LocationStatus status;
@override final  LocationPermissionStatus? permission;
@override final  LocationFix? fix;
@override final  LocationFailure? failure;
@override@JsonKey() final  bool promptDismissed;

/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationStateCopyWith<_LocationState> get copyWith => __$LocationStateCopyWithImpl<_LocationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationState&&(identical(other.status, status) || other.status == status)&&(identical(other.permission, permission) || other.permission == permission)&&(identical(other.fix, fix) || other.fix == fix)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.promptDismissed, promptDismissed) || other.promptDismissed == promptDismissed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,permission,fix,failure,promptDismissed);
}

@override
String toString() {
    return 'LocationState(status: $status, permission: $permission, fix: $fix, failure: $failure, promptDismissed: $promptDismissed)';
}


}

/// @nodoc
abstract mixin class _$LocationStateCopyWith<$Res> implements $LocationStateCopyWith<$Res> {
  factory _$LocationStateCopyWith(_LocationState value, $Res Function(_LocationState) _then) = __$LocationStateCopyWithImpl;
@override @useResult
$Res call({
 LocationStatus status, LocationPermissionStatus? permission, LocationFix? fix, LocationFailure? failure, bool promptDismissed
});


@override $LocationFixCopyWith<$Res>? get fix;

}
/// @nodoc
class __$LocationStateCopyWithImpl<$Res>
    implements _$LocationStateCopyWith<$Res> {
  __$LocationStateCopyWithImpl(this._self, this._then);

  final _LocationState _self;
  final $Res Function(_LocationState) _then;

/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? permission = freezed,Object? fix = freezed,Object? failure = freezed,Object? promptDismissed = null,}) {
  return _then(_LocationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LocationStatus,permission: freezed == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as LocationPermissionStatus?,fix: freezed == fix ? _self.fix : fix // ignore: cast_nullable_to_non_nullable
as LocationFix?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as LocationFailure?,promptDismissed: null == promptDismissed ? _self.promptDismissed : promptDismissed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationFixCopyWith<$Res>? get fix {
    if (_self.fix == null) {
    return null;
  }

  return $LocationFixCopyWith<$Res>(_self.fix!, (value) {
    return _then(_self.copyWith(fix: value));
  });
}
}

// dart format on
