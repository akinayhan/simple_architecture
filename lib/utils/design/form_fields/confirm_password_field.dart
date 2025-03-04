import 'package:flutter/material.dart';

class ConfirmPasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final String label;

  const ConfirmPasswordField({
    super.key,
    required this.passwordController,
    required this.confirmController,
    required this.label,
  });

  @override
  _ConfirmPasswordFieldState createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.confirmController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.label,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _togglePasswordVisibility,
        ),
      ),
      validator: (value) {
        return _validateConfirmPassword();
      },
    );
  }

  String? _validateConfirmPassword() {
    final String password = widget.passwordController.text;
    final String confirmation = widget.confirmController.text;

    if (confirmation.isEmpty) {
      return 'Lütfen parolayı onaylayın.';
    }

    if (password != confirmation) {
      return 'Parolalar uyuşmuyor.';
    }

    return null;
  }
}
