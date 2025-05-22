// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'totp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TotpModel {

 String? get issuer; String? get userName; String? get secret; String? get code; bool? get isShow; String? get iconPath; double? get countdownTime; double? get initialTime;@JsonKey(includeFromJson: false, includeToJson: false) AnimationController? get animationController;@JsonKey(includeFromJson: false, includeToJson: false) Animation<double>? get animation;
/// Create a copy of TotpModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TotpModelCopyWith<TotpModel> get copyWith => _$TotpModelCopyWithImpl<TotpModel>(this as TotpModel, _$identity);

  /// Serializes this TotpModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TotpModel&&(identical(other.issuer, issuer) || other.issuer == issuer)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.code, code) || other.code == code)&&(identical(other.isShow, isShow) || other.isShow == isShow)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&(identical(other.countdownTime, countdownTime) || other.countdownTime == countdownTime)&&(identical(other.initialTime, initialTime) || other.initialTime == initialTime)&&(identical(other.animationController, animationController) || other.animationController == animationController)&&(identical(other.animation, animation) || other.animation == animation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,issuer,userName,secret,code,isShow,iconPath,countdownTime,initialTime,animationController,animation);

@override
String toString() {
  return 'TotpModel(issuer: $issuer, userName: $userName, secret: $secret, code: $code, isShow: $isShow, iconPath: $iconPath, countdownTime: $countdownTime, initialTime: $initialTime, animationController: $animationController, animation: $animation)';
}


}

/// @nodoc
abstract mixin class $TotpModelCopyWith<$Res>  {
  factory $TotpModelCopyWith(TotpModel value, $Res Function(TotpModel) _then) = _$TotpModelCopyWithImpl;
@useResult
$Res call({
 String? issuer, String? userName, String? secret, String? code, bool? isShow, String? iconPath, double? countdownTime, double? initialTime,@JsonKey(includeFromJson: false, includeToJson: false) AnimationController? animationController,@JsonKey(includeFromJson: false, includeToJson: false) Animation<double>? animation
});




}
/// @nodoc
class _$TotpModelCopyWithImpl<$Res>
    implements $TotpModelCopyWith<$Res> {
  _$TotpModelCopyWithImpl(this._self, this._then);

  final TotpModel _self;
  final $Res Function(TotpModel) _then;

/// Create a copy of TotpModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? issuer = freezed,Object? userName = freezed,Object? secret = freezed,Object? code = freezed,Object? isShow = freezed,Object? iconPath = freezed,Object? countdownTime = freezed,Object? initialTime = freezed,Object? animationController = freezed,Object? animation = freezed,}) {
  return _then(_self.copyWith(
issuer: freezed == issuer ? _self.issuer : issuer // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,secret: freezed == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,isShow: freezed == isShow ? _self.isShow : isShow // ignore: cast_nullable_to_non_nullable
as bool?,iconPath: freezed == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String?,countdownTime: freezed == countdownTime ? _self.countdownTime : countdownTime // ignore: cast_nullable_to_non_nullable
as double?,initialTime: freezed == initialTime ? _self.initialTime : initialTime // ignore: cast_nullable_to_non_nullable
as double?,animationController: freezed == animationController ? _self.animationController : animationController // ignore: cast_nullable_to_non_nullable
as AnimationController?,animation: freezed == animation ? _self.animation : animation // ignore: cast_nullable_to_non_nullable
as Animation<double>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TotpModel extends TotpModel {
  const _TotpModel({this.issuer, this.userName, this.secret, this.code, this.isShow, this.iconPath, this.countdownTime, this.initialTime, @JsonKey(includeFromJson: false, includeToJson: false) this.animationController, @JsonKey(includeFromJson: false, includeToJson: false) this.animation}): super._();
  factory _TotpModel.fromJson(Map<String, dynamic> json) => _$TotpModelFromJson(json);

@override final  String? issuer;
@override final  String? userName;
@override final  String? secret;
@override final  String? code;
@override final  bool? isShow;
@override final  String? iconPath;
@override final  double? countdownTime;
@override final  double? initialTime;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  AnimationController? animationController;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  Animation<double>? animation;

/// Create a copy of TotpModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TotpModelCopyWith<_TotpModel> get copyWith => __$TotpModelCopyWithImpl<_TotpModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TotpModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TotpModel&&(identical(other.issuer, issuer) || other.issuer == issuer)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.code, code) || other.code == code)&&(identical(other.isShow, isShow) || other.isShow == isShow)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&(identical(other.countdownTime, countdownTime) || other.countdownTime == countdownTime)&&(identical(other.initialTime, initialTime) || other.initialTime == initialTime)&&(identical(other.animationController, animationController) || other.animationController == animationController)&&(identical(other.animation, animation) || other.animation == animation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,issuer,userName,secret,code,isShow,iconPath,countdownTime,initialTime,animationController,animation);

@override
String toString() {
  return 'TotpModel(issuer: $issuer, userName: $userName, secret: $secret, code: $code, isShow: $isShow, iconPath: $iconPath, countdownTime: $countdownTime, initialTime: $initialTime, animationController: $animationController, animation: $animation)';
}


}

/// @nodoc
abstract mixin class _$TotpModelCopyWith<$Res> implements $TotpModelCopyWith<$Res> {
  factory _$TotpModelCopyWith(_TotpModel value, $Res Function(_TotpModel) _then) = __$TotpModelCopyWithImpl;
@override @useResult
$Res call({
 String? issuer, String? userName, String? secret, String? code, bool? isShow, String? iconPath, double? countdownTime, double? initialTime,@JsonKey(includeFromJson: false, includeToJson: false) AnimationController? animationController,@JsonKey(includeFromJson: false, includeToJson: false) Animation<double>? animation
});




}
/// @nodoc
class __$TotpModelCopyWithImpl<$Res>
    implements _$TotpModelCopyWith<$Res> {
  __$TotpModelCopyWithImpl(this._self, this._then);

  final _TotpModel _self;
  final $Res Function(_TotpModel) _then;

/// Create a copy of TotpModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? issuer = freezed,Object? userName = freezed,Object? secret = freezed,Object? code = freezed,Object? isShow = freezed,Object? iconPath = freezed,Object? countdownTime = freezed,Object? initialTime = freezed,Object? animationController = freezed,Object? animation = freezed,}) {
  return _then(_TotpModel(
issuer: freezed == issuer ? _self.issuer : issuer // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,secret: freezed == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,isShow: freezed == isShow ? _self.isShow : isShow // ignore: cast_nullable_to_non_nullable
as bool?,iconPath: freezed == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String?,countdownTime: freezed == countdownTime ? _self.countdownTime : countdownTime // ignore: cast_nullable_to_non_nullable
as double?,initialTime: freezed == initialTime ? _self.initialTime : initialTime // ignore: cast_nullable_to_non_nullable
as double?,animationController: freezed == animationController ? _self.animationController : animationController // ignore: cast_nullable_to_non_nullable
as AnimationController?,animation: freezed == animation ? _self.animation : animation // ignore: cast_nullable_to_non_nullable
as Animation<double>?,
  ));
}


}

// dart format on
