import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Football nested in a location pin.
class LogoMark extends StatelessWidget {
  const LogoMark({super.key, this.size = 96, this.color = AppColors.white});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(0, -0.25),
      children: [
        Icon(Icons.location_on, size: size, color: color),
        Icon(Icons.sports_soccer, size: size * 0.38, color: AppColors.brandGreen),
      ],
    );
  }
}
