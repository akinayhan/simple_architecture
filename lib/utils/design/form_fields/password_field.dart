import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const PasswordField({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
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
        return _validatePassword(value);
      },
    );
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen ${widget.label} giriniz.';
    }

    if (value.length < 6) {
      return 'Şifre en az 6 karakter içermelidir.';
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+$').hasMatch(value)) {
      return 'Şifre en az bir büyük harf, bir küçük harf, bir rakam ve bir noktalama işareti içermelidir.';
    }

    return null;
  }
}
