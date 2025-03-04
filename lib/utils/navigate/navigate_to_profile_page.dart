import 'package:flutter/material.dart';
import '../../ui/menu/settings/profile_page.dart';

void navigateToProfilePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ProfilePage(),
    ),
  );
}