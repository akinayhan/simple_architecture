import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YearField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const YearField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      decoration: InputDecoration(
        labelText: label,
        hintText: '$label Girin',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lütfen geçerli bir $label giriniz.';
        } else if (value.length != 4) {
          return 'Lütfen 4 haneli bir $label giriniz.';
        } else if (!isNumeric(value)) {
          return 'Lütfen yalnızca rakamlardan oluşan bir $label giriniz.';
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
