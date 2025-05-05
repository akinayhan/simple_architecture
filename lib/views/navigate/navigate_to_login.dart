import 'package:flutter/material.dart';
import '../../main.dart';
import '../screens/login/sign_in_page.dart';

void navigateToLoginPage() {
  MyApp.navigatorKey.currentState?.pushReplacement(
    MaterialPageRoute(
      builder: (context) => const SignInPage(),
    ),
  );
}
