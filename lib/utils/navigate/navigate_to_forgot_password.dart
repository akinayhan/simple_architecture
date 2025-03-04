import 'package:flutter/material.dart';
import '../../ui/login/forgot_password_page.dart';

void goToForgotPasswordScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ForgotPasswordPage(),
    ),
  );
}