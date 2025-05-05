import 'package:flutter/material.dart';
import '../screens/menu/menu/menu_page.dart';

void navigateToMenuPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const MenuPage(),
    ),
  );
}