import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;

  const PhoneField({
    super.key,
    required this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
        _NoZeroStartFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: 'Telefon numarası',
        hintText: 'Lütfen telefon numaranızı girin',
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Lütfen telefon numaranızı girin';
        }
        return _validatePhoneNumber(value!);
      },
    );
  }

  String? _validatePhoneNumber(String value) {
    if (value.length != 10) {
      return 'Telefon numarası 10 hane olmalıdır';
    }
    return null;
  }
}

class _NoZeroStartFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isNotEmpty && newValue.text[0] == '0') {
      return oldValue;
    }
    return newValue;
  }
}
