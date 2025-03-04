import 'package:flutter/material.dart';

class IdentificationNumberField extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;

  const IdentificationNumberField({
    super.key,
    required this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    const String label = 'TC Kimlik Numarası';

    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: label,
        hintText: '$label Girin',
      ),
      maxLength: 11,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lütfen geçerli bir $label giriniz.';
        }
        if (!isNumeric(value)) {
          return '$label sadece rakamlardan oluşmalıdır.';
        }
        if (value.length != 11) {
          return '$label 11 haneli olmalıdır.';
        }
        return null;
      },
    );
  }

  bool isNumeric(String value) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(value);
  }
}
