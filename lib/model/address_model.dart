import 'package:objectbox/objectbox.dart';

@Entity()
class AddressModel {
  @Id()
  int? id;
  String? postalCode;
  String? address;
  String? username;
  String? phoneNumber;
  String? tag;
  bool? isShow;

  AddressModel({this.postalCode, this.address, this.username, this.phoneNumber, this.tag, this.isShow, this.id});

  AddressModel.fromJson(Map<String, dynamic> json) {
    postalCode = json['postalCode'];
    address = json['address'];
    username = json['username'];
    phoneNumber = json['phoneNumber'];
    tag = json['tag'];
    isShow = json['isShow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postalCode'] = postalCode;
    data['address'] = address;
    data['username'] = username;
    data['phoneNumber'] = phoneNumber;
    data['tag'] = tag;
    data['isShow'] = isShow;
    return data;
  }

  AddressModel copyWith({String? postalCode, String? address, String? username, String? phoneNumber, String? tag, bool? isShow, int? id}) {
    return AddressModel(
      id: id ?? this.id,
      postalCode: postalCode ?? this.postalCode,
      address: address ?? this.address,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      tag: tag ?? this.tag,
      isShow: isShow ?? this.isShow,
    );
  }
}
