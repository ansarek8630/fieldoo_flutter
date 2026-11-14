import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/amenity.dart';
import 'amenity_x.dart';

class AmenityChip extends StatelessWidget {
  const AmenityChip({super.key, required this.amenity});
  final Amenity amenity;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(amenity.icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(amenity.label(context)),
        ]),
      );
}
