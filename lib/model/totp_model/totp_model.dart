import 'package:flutter/animation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'totp_model.freezed.dart';
part 'totp_model.g.dart';

@freezed
abstract class TotpModel with _$TotpModel {
  const TotpModel._();
  const factory TotpModel({
    String? issuer,
    String? userName,
    String? secret,
    String? code,
    bool? isShow,
    String? iconPath,
    double? countdownTime,
    double? initialTime,
  }) = _TotpModel;

  factory TotpModel.fromJson(Map<String, Object?> json) =>
      _$TotpModelFromJson(json);
}
