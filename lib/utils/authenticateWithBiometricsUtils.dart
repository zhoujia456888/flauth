import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:local_auth_windows/local_auth_windows.dart';

import '../main.dart';

class AuthenticateWithBiometricsUtils {
  static LocalAuthentication auth = LocalAuthentication();

  static Future<bool> authenticateWithBiometrics() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: '使用生物识别验证您的身份',
        authMessages: [
          const IOSAuthMessages(cancelButton: '取消'),
          const AndroidAuthMessages(signInTitle: '解锁', cancelButton: '取消',
            biometricHint: "使用生物识别进行验证"
          ),
        ],

        options: const AuthenticationOptions(useErrorDialogs: true),
      );
      if (didAuthenticate) {
        logger.e("验证成功");
        return true;
      } else {
        logger.e("验证失败");
        return false;
      }
      // ···
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        SmartDialog.showToast("没有生物识别硬件");
        logger.e("没有硬件");
        return false;
      } else if (e.code == auth_error.notEnrolled) {
        SmartDialog.showToast("未开启生物识别功能");
        logger.e("没有录入");
        return false;
      } else {
        logger.e("其他错误$e");
        return false;
      }
    }
  }
}
