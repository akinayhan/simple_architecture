import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/login/reset_password_model..dart';
import '../../../models/result/api_result.dart';
import '../../../view_model/login/reset_password_view_model.dart';
import '../../widgets/button_design/custom_material_button.dart';
import '../../widgets/dialog_design/quick_alert_utils.dart';
import '../../widgets/form_fields/confirm_password_field.dart';
import '../../widgets/form_fields/generic_field.dart';
import '../../widgets/form_fields/password_field.dart';
import 'sign_in_page.dart';

class ResetPasswordPage extends StatefulWidget {
  final String userId;
  final String token;

  const ResetPasswordPage({
    super.key,
    required this.userId,
    required this.token,
  });

  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final resetPasswordViewModel = Provider.of<ResetPasswordViewModel>(context);
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
              GenericTextField(controller: _numCodeController, label: '6 Haneli Kod'),
              SizedBox(height: screenHeight * 0.02),
              PasswordField(controller: _passwordController, label: 'Yeni Parola'),
              SizedBox(height: screenHeight * 0.02),
              ConfirmPasswordField(passwordController: _passwordController, confirmController: _confirmPasswordController, label: 'Parolayı Onayla'),
              SizedBox(height: screenHeight * 0.02),
              CustomMaterialButton(
                onPressed: () => _onPressedResetPassword(resetPasswordViewModel),
                label: 'Parolayı Güncelle',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedResetPassword(ResetPasswordViewModel resetPasswordViewModel) async {
    if (_formKey.currentState!.validate()) {
      ResetPasswordModel newPasswordModel = ResetPasswordModel(
        userId: widget.userId,
        numCode: _numCodeController.text,
        token: widget.token,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );

      ApiResult result = await resetPasswordViewModel.resetPassword(newPasswordModel);
      _handleApiResult(result);
    }
  }

  void _handleApiResult(ApiResult result) {
    if (result.success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInPage()));
      QuickAlertUtils.showSuccess(context, result.messages.join('\n'));
    } else {
      QuickAlertUtils.showError(context, result.messages.isEmpty ? 'Oturum Sonlanmıştır. Tekrar giriş yapın.' : result.messages.join('\n'));
    }
  }
}
