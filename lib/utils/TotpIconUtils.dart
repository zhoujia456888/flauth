import 'package:FlAuth/assets.dart';
import 'package:get/get.dart';

class TotpIconUtils {

  static Map<String, String> issuerMap = {
    'microsoft': Assets.microsoft,
    'nvidia': Assets.nvidia,
    'binance.com': Assets.binance,
    'epic games': Assets.epicGames,
    'github': Get.isDarkMode?Assets.githubLight :Assets.github,
    'steam': Get.isDarkMode?Assets.steam : Assets.steamLight,
    'google': Assets.google,
    'epic': Assets.epicGames,
  };


  static String? getIconPath(String issuer) {
    String issuerLowerCase = issuer.toLowerCase();
    final String? iconPath = issuerMap[issuerLowerCase];
    return iconPath;
  }
}
