import 'package:flutter/material.dart';
import '../../../utils/function/whatsapp_url_launcher.dart';

ElevatedButton whatsappUrlButton(BuildContext context) {
  return ElevatedButton.icon(
    onPressed: () {
      whatsappLaunchUrl();
    },
    icon: Image.asset('assets/icons/whatsapp.png', height: 24),
    label: const Text('Whatsapp Destek Hattı'),
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(37, 211, 102, 0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 5,
    ),
  );
}