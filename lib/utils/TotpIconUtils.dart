import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TotpIconUtils {
  static String? getIconPath(String issuer) {
    String issuerLowerCase = issuer.toLowerCase();

    if  (issuerLowerCase.contains("github")) {
      issuerLowerCase=Get.isDarkMode?"github_light" : "github";
    }
    if (issuerLowerCase.contains("binance")) {
      issuerLowerCase="binance";
    }
    if (issuerLowerCase.contains("epic")) {
      issuerLowerCase="epic_games";
    }
    if (issuerLowerCase.contains("steam")) {
      issuerLowerCase=Get.isDarkMode?"steam" : "steam_light";
    }
    String iconPath = "assets/totpIcon/$issuerLowerCase.svg";
    return iconPath;
  }
}
