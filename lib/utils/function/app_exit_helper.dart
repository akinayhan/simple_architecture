import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppExitHelper {
  static DateTime? _lastPressedTime;

  static Future<bool> onWillPop(BuildContext context) async {
    DateTime now = DateTime.now();
    if (_lastPressedTime == null ||
        now.difference(_lastPressedTime!) > const Duration(seconds: 2)) {
      _lastPressedTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Çıkmak için tekrar geri basın'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    } else {
      SystemNavigator.pop();
      return true;
    }
  }
}