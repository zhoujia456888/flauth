
import 'package:get/get.dart';

import '../model/totp_model/totp_model.dart';

class TotpUrlUtils {
  /// 生成TOTP URL
  static String generateTOTPUrl(String issuer, String userName, String secret) {
    return 'otpauth://totp/$issuer:$userName?secret=$secret&issuer=$issuer';
  }

  static List<TotpModel> splitTotp(String totpContents) {
    var totpUrlList = totpContents.split("\n");
    if (totpUrlList.isEmpty) {
      return [];
    }
    List<TotpModel> totpMapList = [];
    for (var totpUrl in totpUrlList) {
      if (totpUrl.startsWith("otpauth://totp/")) {
        if (totpUrl.contains("%")) {
          totpUrl = Uri.decodeFull(totpUrl);
        }
        var split = totpUrl.split("otpauth://totp/");
        final queryString = split.length > 1 ? split[1] : '';
        final issuerMatch = RegExp(r'issuer=([^&]+)').firstMatch(queryString);
        final userNameMatch = RegExp(r':([^:?]+)').firstMatch(queryString);
        final secretMatch = RegExp(r'\?secret=([^&]+)').firstMatch(queryString);

        String issuer = issuerMatch?.group(1) ?? '';
        String userName = userNameMatch?.group(1) ?? '';
        String secret = secretMatch?.group(1) ?? '';

        TotpModel totpModel = TotpModel(
          issuer: issuer,
          userName: userName,
          secret: secret,
          code: '',
          isShow: false,
          iconPath:null,
          initialTime: 30,
          countdownTime: 30, id: null,
        );
        totpMapList.add(totpModel);
      } else {

      }
    }

    return totpMapList;
  }
}
