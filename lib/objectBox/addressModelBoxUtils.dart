import 'package:FlAuth/main.dart';
import 'package:FlAuth/model/address_model.dart';

class AddressModelBoxUtils {
  List<AddressModel> getAllAddress() {
    return objectbox.addressModelBox.getAll();
  }

  int addAddress(AddressModel addressModel) {
    return objectbox.addressModelBox.put(addressModel);
  }

  int updateAddress(AddressModel addressModel) {
    return objectbox.addressModelBox.put(addressModel);
  }

  bool deleteAddress(AddressModel addressModel) {
    return objectbox.addressModelBox.remove(addressModel.id!);
  }
}
