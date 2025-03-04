import 'package:flutter/material.dart';

Future<void> selectTime({
  required BuildContext context,
  required TextEditingController controller,
  required Function(DateTime) onTimeSelected,
  bool readOnly = false,
}) async {
  if (readOnly) return;

  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (picked != null) {
    final now = DateTime.now();
    final selectedDateTime = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
    final formattedTime = TimeOfDay(hour: picked.hour, minute: picked.minute).format(context);
    controller.text = formattedTime;
    onTimeSelected(selectedDateTime);
  }
}