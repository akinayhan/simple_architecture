import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameSurnameFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;

  const NameSurnameFormField({
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
      inputFormatters: [
        UpperCaseTextFormatter(),
      ],
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Lütfen $label giriniz.';
        }
        return null;
      },
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: TextSelection.collapsed(offset: newValue.text.length),
    );
  }
}
