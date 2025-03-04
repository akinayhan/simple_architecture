import 'package:flutter/material.dart';
import '../../theme/dark_theme.dart';
import '../../theme/light_theme.dart';

class CustomMaterialButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const CustomMaterialButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).brightness == Brightness.light ? lightTheme : darkTheme,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}