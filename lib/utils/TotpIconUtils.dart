import 'package:FlAuth/assets.dart';
import 'package:get/get.dart';

class TotpIconUtils {
  static Map<String, String> issuerMap = {
    'microsoft': Assets.microsoft,
    'nvidia': Assets.nvidia,
    'binance.com': Assets.binance,
    'epic games': Get.isDarkMode ? Assets.epicgamesDark : Assets.epicgames,
    'github': Get.isDarkMode ? Assets.githubDark : Assets.github,
    'steam': Get.isDarkMode ? Assets.steamDark : Assets.steam,
    'google play': Assets.googleplay,
    'google': Assets.google,
    'epic': Assets.epicgames,
    'twitch': Assets.twitch,
    'discord': Assets.discord,
    'twitter': Assets.twitter,
    'facebook': Assets.facebook,
    'linkedin': Assets.linkedin,
    'youtube': Assets.youtube,
    'instagram': Assets.instagram,
    'reddit': Assets.reddit,
    'tiktok': Assets.tiktok,
    'amazon': Assets.amazon,
    'ebay': Assets.ebay,
    'rustdesk connection': Assets.rustdesk,
    'zoom': Assets.zoom,
    'x': Assets.x,
    'yahoo': Assets.yahoo,
    'spotify': Assets.spotify,
  };

  static String? getIconPath(String issuer) {
    final String normalizedIssuer = issuer.toLowerCase();

    // 优先精确匹配
    final exactMatch = issuerMap[normalizedIssuer];
    if (exactMatch != null) return exactMatch;

    // 前缀匹配
    final prefixMatch = issuerMap.entries.where((entry) => normalizedIssuer.startsWith(entry.key)).firstOrNull;
    if (prefixMatch != null) return prefixMatch.value;

    // 子串匹配
    final substringMatch = issuerMap.entries.where((entry) => normalizedIssuer.contains(entry.key)).firstOrNull;

    if (substringMatch != null) return substringMatch.value;

    // 默认返回 null 或 fallback 图标路径
    return null;
  }
}
