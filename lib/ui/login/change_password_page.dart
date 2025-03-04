import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/result/api_result.dart';
import '../../models/login/change_password_model.dart';
import '../../utils/design/button_design/custom_material_button.dart';
import '../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../utils/design/form_fields/confirm_password_field.dart';
import '../../utils/design/form_fields/password_field.dart';
import '../../utils/function/log_out_helper.dart';
import '../../view_model/login/change_password_view_model.dart';
import '../../view_model/login/log_out_view_model.dart';

class ChangePasswordPage extends StatefulWidget {
  final String token;

  const ChangePasswordPage({
    super.key,
    required this.token,
  });

  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late LogOutViewModel logOutViewModel;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    logOutViewModel = Provider.of<LogOutViewModel>(context, listen: false);
  }


  @override
  Widget build(BuildContext context) {
    final changePasswordViewModel = Provider.of<ChangePasswordViewModel>(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Parola Belirleme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              PasswordField(controller: _oldPasswordController, label: 'Eski Parola'),
              SizedBox(height: screenHeight * 0.02),
              PasswordField(controller: _newPasswordController, label: 'Yeni Parola'),
              SizedBox(height: screenHeight * 0.02),
              ConfirmPasswordField(passwordController: _newPasswordController, confirmController: _confirmPasswordController, label: 'Parola Onayı'),
              SizedBox(height: screenHeight * 0.02),
              CustomMaterialButton(
                onPressed: () => _onPressedResetPassword(changePasswordViewModel),
                label: 'Parolayı Güncelle',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedResetPassword(ChangePasswordViewModel changePasswordViewModel) async {
    if (_formKey.currentState!.validate()) {
      ChangePasswordModel newPasswordModel = ChangePasswordModel(
        oldPassword: _oldPasswordController.text,
        newPassword: _confirmPasswordController.text,
      );
      ApiResult result = await changePasswordViewModel.changePassword(newPasswordModel, widget.token);
      _handleApiResult(result);
    }
  }

  void _handleApiResult(ApiResult result) {
    if (result.success) {
      onPressedLogOut(logOutViewModel, context, widget.token);
      QuickAlertUtils.showSuccess(context, result.messages.join('\n'));
    } else {
      QuickAlertUtils.showError(context, result.messages.isEmpty ? 'Oturum Sonlanmıştır. Tekrar giriş yapın.' : result.messages.join('\n'));
    }
  }
}