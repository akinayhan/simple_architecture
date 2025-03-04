import 'package:flutter/material.dart';

class DialogUtils {
  static Future<bool> showConfirmationDialog(BuildContext context, String title, String content) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Hayır"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Evet"),
            ),
          ],
        );
      },
    ) ?? false;
  }
}