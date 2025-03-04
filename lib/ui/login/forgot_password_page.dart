import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/login/forgot_password_model.dart';
import '../../../../utils/result/data_api_result.dart';
import '../../utils/design/button_design/custom_material_button.dart';
import '../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../utils/design/form_fields/email_field.dart';
import '../../view_model/login/forgot_password_view_model.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordViewModel(),
      child: _ForgotPasswordPageContent(),
    );
  }
}

class _ForgotPasswordPageContent extends StatefulWidget {
  @override
  _ForgotPasswordPageContentState createState() => _ForgotPasswordPageContentState();
}

class _ForgotPasswordPageContentState extends State<_ForgotPasswordPageContent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parola Sıfırlama'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              EmailField(controller: _emailController),
              CustomMaterialButton(
                label: 'Parolayı Sıfırla',
                onPressed: () => _onPressedResetPassword(context),
              ),
              if (_isLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedResetPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final capturedContext = context;

      try {
        _setLoading(true);

        final forgotPasswordViewModel = Provider.of<ForgotPasswordViewModel>(capturedContext, listen: false);
        DataApiResult<ForgotPasswordModel?> result = await forgotPasswordViewModel.sendPasswordResetRequest(email);

        _handleApiResult(capturedContext, result, forgotPasswordViewModel.forgotPasswordData);
      } finally {
        _setLoading(false);
      }
    }
  }

  void _handleApiResult(BuildContext context, DataApiResult<ForgotPasswordModel?> result, ForgotPasswordModel? forgotPasswordModel) {
    if (result.success) {
      _navigateToResetPasswordPage(context, forgotPasswordModel);
      QuickAlertUtils.showSuccess(context, result.messages.join('\n'));
    } else {
      QuickAlertUtils.showError(context, result.messages.join('\n'));
    }
  }

  void _navigateToResetPasswordPage(BuildContext context, ForgotPasswordModel? forgotPasswordModel) async {
    if (forgotPasswordModel != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordPage(
            userId: forgotPasswordModel.userId,
            token: forgotPasswordModel.resetPasswordToken,
          ),
        ),
      );
    }
  }

  void _setLoading(bool isLoading) {
    if (mounted) {
      _isLoading = isLoading;
      setState(() {});
    }
  }
}