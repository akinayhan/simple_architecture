import 'package:flutter/material.dart';

class QuickAlertUtils {
  static void showSuccess(BuildContext context, String message) {
    _show(context, "Başarılı", message);
  }

  static void showError(BuildContext context, String message) {
    _show(context, "Hata", message);
  }

  static void _show(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}