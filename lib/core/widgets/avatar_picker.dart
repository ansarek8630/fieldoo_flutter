import 'dart:io';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Circular avatar with a camera badge. Reused later on the Profile page.
class AvatarPicker extends StatelessWidget {
  const AvatarPicker({super.key, required this.onTap, this.imagePath, this.radius = 52});
  final VoidCallback onTap;
  final String? imagePath;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.outline,
            backgroundImage: imagePath == null ? null : FileImage(File(imagePath!)),
            child: imagePath == null
                ? Icon(Icons.person, size: radius, color: AppColors.textSecondary)
                : null,
          ),
          PositionedDirectional(
            bottom: 0,
            end: 0,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.camera_alt, size: 16, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
