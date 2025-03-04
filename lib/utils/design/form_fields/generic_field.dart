import 'package:flutter/material.dart';

class GenericTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;

  const GenericTextField({
    super.key,
    required this.controller,
    required this.label,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        hintText: '$label Girin',
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Lütfen $label giriniz.';
        }
        return null;
      },
    );
  }
}
