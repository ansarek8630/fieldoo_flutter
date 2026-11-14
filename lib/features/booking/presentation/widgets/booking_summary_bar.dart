import 'package:flutter/material.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';

class BookingSummaryBar extends StatelessWidget {
  const BookingSummaryBar({
    super.key,
    required this.totalPrice,
    required this.canConfirm,
    required this.isLoading,
    required this.onConfirm,
  });
  final int totalPrice;
  final bool canConfirm;
  final bool isLoading;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Material(
      elevation: 8,
      color: AppColors.white,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(l!.total,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              Text(canConfirm ? '$totalPrice AED' : '—',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary, fontWeight: FontWeight.w800)),
            ]),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: AppButton(
                label: canConfirm ? l!.confirmBooking : l!.selectTimeCta,
                isLoading: isLoading,
                onPressed: canConfirm ? onConfirm : null,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
