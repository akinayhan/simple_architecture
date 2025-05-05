import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class LoginPasswordField extends StatefulWidget {
  final TextEditingController controller;

  const LoginPasswordField({
    super.key,
    required this.controller,
  });

  @override
  _LoginPasswordFieldState createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(color: CorporateColors.myWhite),
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.security_outlined, color: CorporateColors.myWhite),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: CorporateColors.myWhite,
          ),
          onPressed: _togglePasswordVisibility,
        ),
        labelText: "Parola",
        labelStyle: const TextStyle(color: CorporateColors.myWhite),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Lütfen parola giriniz.';
        }
        return null;
      },
    );
  }
}
