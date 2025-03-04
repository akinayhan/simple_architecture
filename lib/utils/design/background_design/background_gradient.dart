import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.0, -1.0),
          end: Alignment(0.0, 1.0),
          colors: [
            CorporateColors.logoColor3,
            CorporateColors.logoColor8,
          ],
          stops: [0.2, 1.0],
        ),
      ),
    );
  }
}