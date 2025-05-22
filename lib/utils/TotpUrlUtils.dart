import 'package:flutter/animation.dart';

class TotpUrlUtils {
  /// 生成TOTP URL
  static String generateTOTPUrl(String issuer, String userName, String secret) {
    return 'otpauth://totp/$issuer:$userName?secret=$secret&issuer=$issuer';
  }

  static List splitTotp(String totpContents) {
    var totpMap = {"issuer": "", "userName": "", "secret": "", "iconPath": "", "initialTime": 30};
    var totpUrlList=  totpContents.split("\n");
    if  (totpUrlList.isEmpty) {
      return [];
    }
    var totpMapList  = [];
    for (var totpUrl in totpUrlList) {
      if (totpUrl.startsWith("otpauth://totp/")) {
        var split = totpUrl.split("/");
        totpMap["issuer"] = split[2].split(":")[0];
        totpMap["userName"] = split[2].split(":")[1];
        totpMap["secret"] = split[3].split("?")[0];
        if (split[3].split("?").length > 1) {
          var params = split[3].split("?")[1].split("&");
          for (var param in params) {
            if (param.startsWith("issuer=")) {
              totpMap["issuer"] = param.split("=")[1];
            } else if (param.startsWith("secret=")) {
              totpMap["secret"] = param.split("=")[1];
            } else if (param.startsWith("initialTime=")) {
              totpMap["initialTime"] = int.parse(param.split("=")[1]);
            }
          }
        }
        totpMapList.add(totpMap);
      }else{

      }
    }

    return totpMapList;
  }
}
