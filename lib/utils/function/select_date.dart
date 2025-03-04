import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../design/dialog_design/quick_alert_utils.dart';

Future<void> selectDate({
  required BuildContext context,
  required TextEditingController controller,
  required bool isStartDate,
  required String? startDate,
  required String? endDate,
  required Function(String) onDateSelected,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    locale: const Locale('tr', 'TR'),
  );

  if (picked != null) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
    if (isStartDate) {
      if (endDate != null && DateTime.parse(formattedDate).isAfter(DateTime.parse(endDate))) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          QuickAlertUtils.showError(context, 'Başlangıç tarihi, bitiş tarihinden sonra olamaz.');
        });
      } else {
        controller.text = formattedDate;
        onDateSelected(formattedDate);
      }
    } else {
      if (startDate != null && DateTime.parse(formattedDate).isBefore(DateTime.parse(startDate))) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          QuickAlertUtils.showError(context, 'Bitiş tarihi, başlangıç tarihinden önce olamaz.');
        });
      } else {
        controller.text = formattedDate;
        onDateSelected(formattedDate);
      }
    }
  }
}