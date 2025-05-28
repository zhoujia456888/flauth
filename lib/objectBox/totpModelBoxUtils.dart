import 'package:FlAuth/main.dart';
import 'package:FlAuth/model/totp_model.dart';
import 'package:FlAuth/objectBox/objectBox.dart';

class TotpModelBoxUtils {
  //  获取所有TOTP
  getAllTotp() {
    return objectbox.totpModelBox.getAll();
  }

  //  批量添加TOTP
  addTotpList(List<TotpModel> totpModelList) {
    objectbox.totpModelBox.putMany(totpModelList);
  }

  //  添加TOTP
  addTotp(TotpModel totpModel) {
    objectbox.totpModelBox.put(totpModel);
  }

  //  更新TOTP
  updateTotp(TotpModel totpModel) {
    objectbox.totpModelBox.put(totpModel);
  }

  //  删除TOTP
  deleteTotp(TotpModel totpModel) {
    objectbox.totpModelBox.remove(totpModel.id!);
  }
}
