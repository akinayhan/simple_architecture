import 'package:flutter/material.dart';
import '../../theme/dark_theme.dart';
import '../../theme/light_theme.dart';

class ChangeMaterialButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const ChangeMaterialButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).brightness == Brightness.light ? lightTheme : darkTheme,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
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