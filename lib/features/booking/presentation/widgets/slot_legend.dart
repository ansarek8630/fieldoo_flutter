import 'package:flutter/material.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_colors.dart';

class SlotLegend extends StatelessWidget {
  const SlotLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Wrap(spacing: 16, children: [
      _Dot(AppColors.available, l!.legendAvailable),
      _Dot(AppColors.booked, l.legendBooked),
      _Dot(AppColors.primary, l.legendSelected, filled: true),
    ]);
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.color, this.label, {this.filled = false});
  final Color color;
  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: filled || color == AppColors.booked ? color : Colors.transparent,
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ]);
}
