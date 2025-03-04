import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const NumberField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: '$label Girin',
      ),
      validator: (value) {
        if (value?.isEmpty ?? true ) {
          return 'Lütfen geçerli bir $label giriniz.';
        }
        return null;
      },
    );
  }

  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}