import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> dateSelectOnly({
  required BuildContext context,
  required TextEditingController controller,
  required Function(DateTime) onDateSelected,
  bool readOnly = false,
}) async {
  if (readOnly) {
    return;
  }

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2100),
    locale: const Locale('tr', 'TR'),
  );

  if (picked != null) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
    controller.text = formattedDate;
    onDateSelected(picked);
  }
}
