import 'package:FlAuth/main.dart';
import 'package:FlAuth/model/password_model.dart';

class PasswordModelBoxUtils {
  void addPasswordList(List<PasswordModel> passwordModelList) {
    objectbox.passwordModelBox.putMany(passwordModelList);
  }

  List<PasswordModel> getAllPassword() {
    var passwordList = objectbox.passwordModelBox.getAll();
    passwordList.sort((a, b) => a.title!.compareTo(b.title!));
    return passwordList;
  }

  int addPassword(PasswordModel passwordModel) {
   return objectbox.passwordModelBox.put(passwordModel);
  }

  int updatePassword(PasswordModel passwordModel) {
    return objectbox.passwordModelBox.put(passwordModel);
  }

  bool deletePassword(PasswordModel passwordModel) {
    return objectbox.passwordModelBox.remove(passwordModel.id!);
  }
}
