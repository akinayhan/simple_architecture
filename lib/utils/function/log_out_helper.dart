import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/navigate/navigate_to_login.dart';
import '../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../utils/function/delete_shared_preferences.dart';
import '../../utils/result/api_result.dart';
import '../../view_model/login/log_out_view_model.dart';

class LogOutHelper {
  static Future<void> logOut(BuildContext context, String token) async {
    final logOutViewModel = Provider.of<LogOutViewModel>(context, listen: false);
    ApiResult result = await logOutViewModel.logOut(token);
    handleApiResult(context, result);
  }

  static void handleApiResult(BuildContext context, ApiResult result) {
    if (result.success) {
      navigateToLoginPage();
      clearAllSharedPreferences();
      QuickAlertUtils.showSuccess(context, result.messages.join('\n'));
    } else {
      if (result.messages.isEmpty) {
        navigateToLoginPage();
        QuickAlertUtils.showError(context, 'Oturum Sonlanmıştır. Tekrar giriş yapın.');
      } else {
        QuickAlertUtils.showError(context, result.messages.join('\n'));
      }
    }
  }
}

void onPressedLogOut(LogOutViewModel logOutViewModel, BuildContext context, String token) async {
  await LogOutHelper.logOut(context, token);
}