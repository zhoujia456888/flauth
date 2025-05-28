import 'package:FlAuth/main.dart';
import 'package:FlAuth/model/password_model.dart';

class PasswordModelBoxUtils {
  addPasswordList(List<PasswordModel> passwordModelList) {
    objectbox.passwordModelBox.putMany(passwordModelList);
  }

  getAllPassword() {
    return objectbox.passwordModelBox.getAll();
  }

  addPassword(PasswordModel passwordModel) {
    objectbox.passwordModelBox.put(passwordModel);
  }

  updatePassword(PasswordModel passwordModel) {
    objectbox.passwordModelBox.put(passwordModel);
  }

  deletePassword(PasswordModel passwordModel) {
    objectbox.passwordModelBox.remove(passwordModel.id!);
  }
}
