import 'package:flutter/material.dart';
import '../../ui/login/sign_up_page.dart';

void goToSignUpPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SignUpPage(),
    ),
  );
}