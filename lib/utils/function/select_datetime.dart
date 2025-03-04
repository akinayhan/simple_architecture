import 'package:flutter/material.dart';

Future<void> selectDateTime({
  required BuildContext context,
  required TextEditingController controller,
  required bool isStartDate,
  DateTime? startDate,
  DateTime? endDate,
  required Function(DateTime) onDateSelected,
  bool readOnly = false,
}) async {
  if (readOnly) {
    return;
  }

  DateTime initialDate = isStartDate
      ? (startDate ?? DateTime.now())
      : (endDate ?? DateTime.now());
  DateTime firstDate = DateTime(2000);
  DateTime lastDate = DateTime(2100);

  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (picked != null) {
    controller.text = "${picked.toLocal()}".split(' ')[0];
    onDateSelected(picked);
  }
}
