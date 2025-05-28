import 'package:objectbox/objectbox.dart';

@Entity()
class PasswordModel {
  @Id()
  int? id;
  String? title;
  String? url;
  String? username;
  String? password;
  bool? isShow;

  PasswordModel({this.id, this.title, this.url, this.username, this.password, this.isShow});

  factory PasswordModel.fromJson(Map<String, dynamic> json) => PasswordModel(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    username: json["username"],
    password: json["password"],
    isShow: json["isShow"],
  );

  Map<String, dynamic> toJson() => {"id": id, "title": title, "url": url, "username": username, "password": password, "isShow": isShow};

  PasswordModel? copyWith({int? id, String? title, String? url, String? username, String? password, bool? isShow}) {
    return PasswordModel(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      username: username ?? this.username,
      password: password ?? this.password,
      isShow: isShow ?? this.isShow,
    );
  }
}
