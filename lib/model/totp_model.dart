import 'package:objectbox/objectbox.dart';

@Entity()
class TotpModel {
  @Id()
  int? id;
  String? issuer;
  String? userName;
  String? secret;
  String? code;
  bool? isShow;
  String? iconPath;
  double? countdownTime;
  double? initialTime;

  TotpModel({
    this.id,
    this.issuer,
    this.userName,
    this.secret,
    this.code,
    this.isShow,
    this.iconPath,
    this.countdownTime,
    this.initialTime,
  });

  factory TotpModel.fromJson(Map<String, dynamic> json) => TotpModel(
    id: json["id"],
    issuer: json["issuer"],
    userName: json["userName"],
    secret: json["secret"],
    code: json["code"],
    isShow: json["isShow"],
    iconPath: json["iconPath"],
    countdownTime: json["countdownTime"],
    initialTime: json["initialTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "issuer": issuer,
    "userName": userName,
    "secret": secret,
    "code": code,
    "isShow": isShow,
    "iconPath": iconPath,
    "countdownTime": countdownTime,
    "initialTime": initialTime,
  };

  TotpModel? copyWith({
    int? id,
    String? issuer,
    String? userName,
    String? secret,
    String? code,
    bool? isShow,
    String? iconPath,
    double? countdownTime,
    double? initialTime,
    bool? canLoadAssets,
  }) {
    return TotpModel(
      id: id ?? this.id,
      issuer: issuer ?? this.issuer,
      userName: userName ?? this.userName,
      secret: secret ?? this.secret,
      code: code ?? this.code,
      isShow: isShow ?? this.isShow,
      iconPath: iconPath ?? this.iconPath,
      countdownTime: countdownTime ?? this.countdownTime,
      initialTime: initialTime ?? this.initialTime,
    );
  }
}
