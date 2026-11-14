import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';

/// Horizontal 7-day picker starting today.
class DateStrip extends StatelessWidget {
  const DateStrip({super.key, required this.selected, required this.onSelected, this.days = 7});
  final DateTime selected;
  final ValueChanged<DateTime> onSelected;
  final int days;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);

    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final d = DateTime(start.year, start.month, start.day + i);
          final isSelected = d == selected;
          final fg = isSelected ? AppColors.white : AppColors.textPrimary;
          return InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => onSelected(d),
            child: Container(
              width: 62,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isSelected ? AppColors.primary : AppColors.outline),
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(DateFormat.E(locale).format(d),
                    style: TextStyle(color: fg, fontSize: 12)),
                const SizedBox(height: 4),
                Text(DateFormat.d(locale).format(d),
                    style: TextStyle(color: fg, fontSize: 20, fontWeight: FontWeight.w800)),
              ]),
            ),
          );
        },
      ),
    );
  }
}
