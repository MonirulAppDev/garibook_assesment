// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flavor_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FlavorConfig {

 Flavor get flavor; String get appName; String get packageName; String get osrmBaseUrl; String get tileUrlTemplate; bool get showDevBadge; bool get enableNetworkLogs; int get connectTimeoutMs; int get receiveTimeoutMs;
/// Create a copy of FlavorConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlavorConfigCopyWith<FlavorConfig> get copyWith => _$FlavorConfigCopyWithImpl<FlavorConfig>(this as FlavorConfig, _$identity);

  /// Serializes this FlavorConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FlavorConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlavorConfig&&(identical(other.flavor, _this.flavor) || other.flavor == _this.flavor)&&(identical(other.appName, _this.appName) || other.appName == _this.appName)&&(identical(other.packageName, _this.packageName) || other.packageName == _this.packageName)&&(identical(other.osrmBaseUrl, _this.osrmBaseUrl) || other.osrmBaseUrl == _this.osrmBaseUrl)&&(identical(other.tileUrlTemplate, _this.tileUrlTemplate) || other.tileUrlTemplate == _this.tileUrlTemplate)&&(identical(other.showDevBadge, _this.showDevBadge) || other.showDevBadge == _this.showDevBadge)&&(identical(other.enableNetworkLogs, _this.enableNetworkLogs) || other.enableNetworkLogs == _this.enableNetworkLogs)&&(identical(other.connectTimeoutMs, _this.connectTimeoutMs) || other.connectTimeoutMs == _this.connectTimeoutMs)&&(identical(other.receiveTimeoutMs, _this.receiveTimeoutMs) || other.receiveTimeoutMs == _this.receiveTimeoutMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FlavorConfig;
  return Object.hash(runtimeType,_this.flavor,_this.appName,_this.packageName,_this.osrmBaseUrl,_this.tileUrlTemplate,_this.showDevBadge,_this.enableNetworkLogs,_this.connectTimeoutMs,_this.receiveTimeoutMs);
}

@override
String toString() {
  final _this = this as FlavorConfig;
  return 'FlavorConfig(flavor: ${_this.flavor}, appName: ${_this.appName}, packageName: ${_this.packageName}, osrmBaseUrl: ${_this.osrmBaseUrl}, tileUrlTemplate: ${_this.tileUrlTemplate}, showDevBadge: ${_this.showDevBadge}, enableNetworkLogs: ${_this.enableNetworkLogs}, connectTimeoutMs: ${_this.connectTimeoutMs}, receiveTimeoutMs: ${_this.receiveTimeoutMs})';
}


}

/// @nodoc
abstract mixin class $FlavorConfigCopyWith<$Res>  {
  factory $FlavorConfigCopyWith(FlavorConfig value, $Res Function(FlavorConfig) _then) = _$FlavorConfigCopyWithImpl;
@useResult
$Res call({
 Flavor flavor, String appName, String packageName, String osrmBaseUrl, String tileUrlTemplate, bool showDevBadge, bool enableNetworkLogs, int connectTimeoutMs, int receiveTimeoutMs
});




}
/// @nodoc
class _$FlavorConfigCopyWithImpl<$Res>
    implements $FlavorConfigCopyWith<$Res> {
  _$FlavorConfigCopyWithImpl(this._self, this._then);

  final FlavorConfig _self;
  final $Res Function(FlavorConfig) _then;

/// Create a copy of FlavorConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flavor = null,Object? appName = null,Object? packageName = null,Object? osrmBaseUrl = null,Object? tileUrlTemplate = null,Object? showDevBadge = null,Object? enableNetworkLogs = null,Object? connectTimeoutMs = null,Object? receiveTimeoutMs = null,}) {
  return _then(FlavorConfig(
flavor: null == flavor ? _self.flavor : flavor // ignore: cast_nullable_to_non_nullable
as Flavor,appName: null == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String,packageName: null == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String,osrmBaseUrl: null == osrmBaseUrl ? _self.osrmBaseUrl : osrmBaseUrl // ignore: cast_nullable_to_non_nullable
as String,tileUrlTemplate: null == tileUrlTemplate ? _self.tileUrlTemplate : tileUrlTemplate // ignore: cast_nullable_to_non_nullable
as String,showDevBadge: null == showDevBadge ? _self.showDevBadge : showDevBadge // ignore: cast_nullable_to_non_nullable
as bool,enableNetworkLogs: null == enableNetworkLogs ? _self.enableNetworkLogs : enableNetworkLogs // ignore: cast_nullable_to_non_nullable
as bool,connectTimeoutMs: null == connectTimeoutMs ? _self.connectTimeoutMs : connectTimeoutMs // ignore: cast_nullable_to_non_nullable
as int,receiveTimeoutMs: null == receiveTimeoutMs ? _self.receiveTimeoutMs : receiveTimeoutMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FlavorConfig].
extension FlavorConfigPatterns on FlavorConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlavorConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlavorConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlavorConfig value)  $default,){
final _that = this;
switch (_that) {
case _FlavorConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlavorConfig value)?  $default,){
final _that = this;
switch (_that) {
case _FlavorConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Flavor flavor,  String appName,  String packageName,  String osrmBaseUrl,  String tileUrlTemplate,  bool showDevBadge,  bool enableNetworkLogs,  int connectTimeoutMs,  int receiveTimeoutMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlavorConfig() when $default != null:
return $default(_that.flavor,_that.appName,_that.packageName,_that.osrmBaseUrl,_that.tileUrlTemplate,_that.showDevBadge,_that.enableNetworkLogs,_that.connectTimeoutMs,_that.receiveTimeoutMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Flavor flavor,  String appName,  String packageName,  String osrmBaseUrl,  String tileUrlTemplate,  bool showDevBadge,  bool enableNetworkLogs,  int connectTimeoutMs,  int receiveTimeoutMs)  $default,) {final _that = this;
switch (_that) {
case _FlavorConfig():
return $default(_that.flavor,_that.appName,_that.packageName,_that.osrmBaseUrl,_that.tileUrlTemplate,_that.showDevBadge,_that.enableNetworkLogs,_that.connectTimeoutMs,_that.receiveTimeoutMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Flavor flavor,  String appName,  String packageName,  String osrmBaseUrl,  String tileUrlTemplate,  bool showDevBadge,  bool enableNetworkLogs,  int connectTimeoutMs,  int receiveTimeoutMs)?  $default,) {final _that = this;
switch (_that) {
case _FlavorConfig() when $default != null:
return $default(_that.flavor,_that.appName,_that.packageName,_that.osrmBaseUrl,_that.tileUrlTemplate,_that.showDevBadge,_that.enableNetworkLogs,_that.connectTimeoutMs,_that.receiveTimeoutMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlavorConfig extends FlavorConfig {
  const _FlavorConfig({required this.flavor, required this.appName, required this.packageName, required this.osrmBaseUrl, required this.tileUrlTemplate, this.showDevBadge = false, this.enableNetworkLogs = false, this.connectTimeoutMs = 8000, this.receiveTimeoutMs = 12000}): super._();
  factory _FlavorConfig.fromJson(Map<String, dynamic> json) => _$FlavorConfigFromJson(json);

@override final  Flavor flavor;
@override final  String appName;
@override final  String packageName;
@override final  String osrmBaseUrl;
@override final  String tileUrlTemplate;
@override@JsonKey() final  bool showDevBadge;
@override@JsonKey() final  bool enableNetworkLogs;
@override@JsonKey() final  int connectTimeoutMs;
@override@JsonKey() final  int receiveTimeoutMs;

/// Create a copy of FlavorConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlavorConfigCopyWith<_FlavorConfig> get copyWith => __$FlavorConfigCopyWithImpl<_FlavorConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlavorConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlavorConfig&&(identical(other.flavor, flavor) || other.flavor == flavor)&&(identical(other.appName, appName) || other.appName == appName)&&(identical(other.packageName, packageName) || other.packageName == packageName)&&(identical(other.osrmBaseUrl, osrmBaseUrl) || other.osrmBaseUrl == osrmBaseUrl)&&(identical(other.tileUrlTemplate, tileUrlTemplate) || other.tileUrlTemplate == tileUrlTemplate)&&(identical(other.showDevBadge, showDevBadge) || other.showDevBadge == showDevBadge)&&(identical(other.enableNetworkLogs, enableNetworkLogs) || other.enableNetworkLogs == enableNetworkLogs)&&(identical(other.connectTimeoutMs, connectTimeoutMs) || other.connectTimeoutMs == connectTimeoutMs)&&(identical(other.receiveTimeoutMs, receiveTimeoutMs) || other.receiveTimeoutMs == receiveTimeoutMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,flavor,appName,packageName,osrmBaseUrl,tileUrlTemplate,showDevBadge,enableNetworkLogs,connectTimeoutMs,receiveTimeoutMs);
}

@override
String toString() {
    return 'FlavorConfig(flavor: $flavor, appName: $appName, packageName: $packageName, osrmBaseUrl: $osrmBaseUrl, tileUrlTemplate: $tileUrlTemplate, showDevBadge: $showDevBadge, enableNetworkLogs: $enableNetworkLogs, connectTimeoutMs: $connectTimeoutMs, receiveTimeoutMs: $receiveTimeoutMs)';
}


}

/// @nodoc
abstract mixin class _$FlavorConfigCopyWith<$Res> implements $FlavorConfigCopyWith<$Res> {
  factory _$FlavorConfigCopyWith(_FlavorConfig value, $Res Function(_FlavorConfig) _then) = __$FlavorConfigCopyWithImpl;
@override @useResult
$Res call({
 Flavor flavor, String appName, String packageName, String osrmBaseUrl, String tileUrlTemplate, bool showDevBadge, bool enableNetworkLogs, int connectTimeoutMs, int receiveTimeoutMs
});




}
/// @nodoc
class __$FlavorConfigCopyWithImpl<$Res>
    implements _$FlavorConfigCopyWith<$Res> {
  __$FlavorConfigCopyWithImpl(this._self, this._then);

  final _FlavorConfig _self;
  final $Res Function(_FlavorConfig) _then;

/// Create a copy of FlavorConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flavor = null,Object? appName = null,Object? packageName = null,Object? osrmBaseUrl = null,Object? tileUrlTemplate = null,Object? showDevBadge = null,Object? enableNetworkLogs = null,Object? connectTimeoutMs = null,Object? receiveTimeoutMs = null,}) {
  return _then(_FlavorConfig(
flavor: null == flavor ? _self.flavor : flavor // ignore: cast_nullable_to_non_nullable
as Flavor,appName: null == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String,packageName: null == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String,osrmBaseUrl: null == osrmBaseUrl ? _self.osrmBaseUrl : osrmBaseUrl // ignore: cast_nullable_to_non_nullable
as String,tileUrlTemplate: null == tileUrlTemplate ? _self.tileUrlTemplate : tileUrlTemplate // ignore: cast_nullable_to_non_nullable
as String,showDevBadge: null == showDevBadge ? _self.showDevBadge : showDevBadge // ignore: cast_nullable_to_non_nullable
as bool,enableNetworkLogs: null == enableNetworkLogs ? _self.enableNetworkLogs : enableNetworkLogs // ignore: cast_nullable_to_non_nullable
as bool,connectTimeoutMs: null == connectTimeoutMs ? _self.connectTimeoutMs : connectTimeoutMs // ignore: cast_nullable_to_non_nullable
as int,receiveTimeoutMs: null == receiveTimeoutMs ? _self.receiveTimeoutMs : receiveTimeoutMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
