import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

enum SlotVisual { available, booked, selected }

class SlotChip extends StatelessWidget {
  const SlotChip({super.key, required this.label, required this.visual, this.onTap});
  final String label;
  final SlotVisual visual;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, border) = switch (visual) {
      SlotVisual.available => (AppColors.white, AppColors.available, AppColors.available),
      SlotVisual.booked => (AppColors.outline, AppColors.textSecondary, AppColors.outline),
      SlotVisual.selected => (AppColors.primary, AppColors.white, AppColors.primary),
    };
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: visual == SlotVisual.booked ? null : onTap,
      child: Container(
        width: 88,
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: border),
        ),
        child: Text(label,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w700,
              decoration: visual == SlotVisual.booked ? TextDecoration.lineThrough : null,
            )),
      ),
    );
  }
}
