import 'package:flutter/material.dart';

class NumberReadField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;

  const NumberReadField({
    Key? key,
    required this.controller,
    required this.label,
    required this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: '$label Girin',
        errorText: _validateInput(controller.text) ? null : 'Lütfen geçerli bir $label giriniz.',
      ),
    );
  }

  bool _validateInput(String value) {
    if (value.isEmpty) return false;
    final number = double.tryParse(value);
    return number != null;
  }
}
