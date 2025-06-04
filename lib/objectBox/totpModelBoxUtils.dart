import 'package:FlAuth/main.dart';
import 'package:FlAuth/model/totp_model.dart';
import 'package:FlAuth/objectBox/objectBox.dart';

class TotpModelBoxUtils {
  //  获取所有TOTP
  List<TotpModel> getAllTotp() {
    return objectbox.totpModelBox.getAll();
  }

  //  批量添加TOTP
  void addTotpList(List<TotpModel> totpModelList) {
    objectbox.totpModelBox.putMany(totpModelList);
  }

  //  添加TOTP
  void addTotp(TotpModel totpModel) {
    objectbox.totpModelBox.put(totpModel);
  }

  //  更新TOTP
  void updateTotp(TotpModel totpModel) {
    objectbox.totpModelBox.put(totpModel);
  }

  //  删除TOTP
  bool deleteTotp(TotpModel totpModel) {
    return objectbox.totpModelBox.remove(totpModel.id!);
  }
}
