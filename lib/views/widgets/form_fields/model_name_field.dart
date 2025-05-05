import 'package:flutter/material.dart';

class ModelNameField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const ModelNameField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: '$label Girin',
      ),
      onChanged: (value) {
        final validCharacters = RegExp(r'^[A-Za-z0-9 ]*$');
        String newValue = value.toUpperCase();
        if (!validCharacters.hasMatch(newValue)) {
          newValue = newValue.replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '');
        }
        if (controller.text != newValue) {
          controller.text = newValue;
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        }
      },
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Lütfen $label giriniz.';
        }
        return null;
      },
    );
  }
}
