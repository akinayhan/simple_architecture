import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class LoginUserNameField extends StatelessWidget {
  final TextEditingController controller;

  const LoginUserNameField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: CorporateColors.myWhite),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.verified_user_outlined, color: CorporateColors.myWhite),
        labelText: "Kullanıcı Adı",
        labelStyle: TextStyle(color: CorporateColors.myWhite),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Lütfen kullanıcı adı giriniz.';
        }
        return null;
      },
    );
  }
}