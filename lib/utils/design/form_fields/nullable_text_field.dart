import 'package:flutter/material.dart';

class NullableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final int? maxLines;

  const NullableTextField({
    super.key,
    required this.controller,
    required this.label,
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: '$label Girin',
      ),
    );
  }
}