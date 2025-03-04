import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../design/dialog_design/quick_alert_utils.dart';

Future<void> selectBirthDate({
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
    initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    locale: const Locale('tr', 'TR'),
  );

  if (picked != null) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(picked);

    final minimumAgeDate = DateTime.now().subtract(const Duration(days: 365 * 18));
    if (picked.isAfter(minimumAgeDate)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        QuickAlertUtils.showError(context, 'Doğum tarihi en az 18 yaşında olmalısınız.');
      });
    } else {
      controller.text = formattedDate;
      onDateSelected(picked);
    }
  }
}
