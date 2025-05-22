// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TotpModel _$TotpModelFromJson(Map<String, dynamic> json) => _TotpModel(
  issuer: json['issuer'] as String?,
  userName: json['userName'] as String?,
  secret: json['secret'] as String?,
  code: json['code'] as String?,
  isShow: json['isShow'] as bool?,
  iconPath: json['iconPath'] as String?,
  countdownTime: (json['countdownTime'] as num?)?.toDouble(),
  initialTime: (json['initialTime'] as num?)?.toDouble(),
);

Map<String, dynamic> _$TotpModelToJson(_TotpModel instance) =>
    <String, dynamic>{
      'issuer': instance.issuer,
      'userName': instance.userName,
      'secret': instance.secret,
      'code': instance.code,
      'isShow': instance.isShow,
      'iconPath': instance.iconPath,
      'countdownTime': instance.countdownTime,
      'initialTime': instance.initialTime,
    };
