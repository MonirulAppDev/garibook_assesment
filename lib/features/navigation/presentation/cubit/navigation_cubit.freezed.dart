// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NavigationState {

/// Null when there is no route loaded.
 NavigationFrame? get frame;/// Camera follows the car until the user pans the map.
 bool get following; SpeedMultiplier get speed;
/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationStateCopyWith<NavigationState> get copyWith => _$NavigationStateCopyWithImpl<NavigationState>(this as NavigationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NavigationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationState&&(identical(other.frame, _this.frame) || other.frame == _this.frame)&&(identical(other.following, _this.following) || other.following == _this.following)&&(identical(other.speed, _this.speed) || other.speed == _this.speed));
}


@override
int get hashCode {
  final _this = this as NavigationState;
  return Object.hash(runtimeType,_this.frame,_this.following,_this.speed);
}

@override
String toString() {
  final _this = this as NavigationState;
  return 'NavigationState(frame: ${_this.frame}, following: ${_this.following}, speed: ${_this.speed})';
}


}

/// @nodoc
abstract mixin class $NavigationStateCopyWith<$Res>  {
  factory $NavigationStateCopyWith(NavigationState value, $Res Function(NavigationState) _then) = _$NavigationStateCopyWithImpl;
@useResult
$Res call({
 NavigationFrame? frame, bool following, SpeedMultiplier speed
});


$NavigationFrameCopyWith<$Res>? get frame;

}
/// @nodoc
class _$NavigationStateCopyWithImpl<$Res>
    implements $NavigationStateCopyWith<$Res> {
  _$NavigationStateCopyWithImpl(this._self, this._then);

  final NavigationState _self;
  final $Res Function(NavigationState) _then;

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? frame = freezed,Object? following = null,Object? speed = null,}) {
  return _then(NavigationState(
frame: freezed == frame ? _self.frame : frame // ignore: cast_nullable_to_non_nullable
as NavigationFrame?,following: null == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as bool,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as SpeedMultiplier,
  ));
}
/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NavigationFrameCopyWith<$Res>? get frame {
    if (_self.frame == null) {
    return null;
  }

  return $NavigationFrameCopyWith<$Res>(_self.frame!, (value) {
    return _then(_self.copyWith(frame: value));
  });
}
}


/// Adds pattern-matching-related methods to [NavigationState].
extension NavigationStatePatterns on NavigationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigationState value)  $default,){
final _that = this;
switch (_that) {
case _NavigationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavigationState value)?  $default,){
final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NavigationFrame? frame,  bool following,  SpeedMultiplier speed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
return $default(_that.frame,_that.following,_that.speed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NavigationFrame? frame,  bool following,  SpeedMultiplier speed)  $default,) {final _that = this;
switch (_that) {
case _NavigationState():
return $default(_that.frame,_that.following,_that.speed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NavigationFrame? frame,  bool following,  SpeedMultiplier speed)?  $default,) {final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
return $default(_that.frame,_that.following,_that.speed);case _:
  return null;

}
}

}

/// @nodoc


class _NavigationState extends NavigationState {
  const _NavigationState({this.frame, this.following = true, this.speed = SpeedMultiplier.x1}): super._();
  

/// Null when there is no route loaded.
@override final  NavigationFrame? frame;
/// Camera follows the car until the user pans the map.
@override@JsonKey() final  bool following;
@override@JsonKey() final  SpeedMultiplier speed;

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigationStateCopyWith<_NavigationState> get copyWith => __$NavigationStateCopyWithImpl<_NavigationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigationState&&(identical(other.frame, frame) || other.frame == frame)&&(identical(other.following, following) || other.following == following)&&(identical(other.speed, speed) || other.speed == speed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,frame,following,speed);
}

@override
String toString() {
    return 'NavigationState(frame: $frame, following: $following, speed: $speed)';
}


}

/// @nodoc
abstract mixin class _$NavigationStateCopyWith<$Res> implements $NavigationStateCopyWith<$Res> {
  factory _$NavigationStateCopyWith(_NavigationState value, $Res Function(_NavigationState) _then) = __$NavigationStateCopyWithImpl;
@override @useResult
$Res call({
 NavigationFrame? frame, bool following, SpeedMultiplier speed
});


@override $NavigationFrameCopyWith<$Res>? get frame;

}
/// @nodoc
class __$NavigationStateCopyWithImpl<$Res>
    implements _$NavigationStateCopyWith<$Res> {
  __$NavigationStateCopyWithImpl(this._self, this._then);

  final _NavigationState _self;
  final $Res Function(_NavigationState) _then;

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? frame = freezed,Object? following = null,Object? speed = null,}) {
  return _then(_NavigationState(
frame: freezed == frame ? _self.frame : frame // ignore: cast_nullable_to_non_nullable
as NavigationFrame?,following: null == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as bool,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as SpeedMultiplier,
  ));
}

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NavigationFrameCopyWith<$Res>? get frame {
    if (_self.frame == null) {
    return null;
  }

  return $NavigationFrameCopyWith<$Res>(_self.frame!, (value) {
    return _then(_self.copyWith(frame: value));
  });
}
}

// dart format on
