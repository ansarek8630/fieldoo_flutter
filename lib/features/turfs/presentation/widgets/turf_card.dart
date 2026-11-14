import 'package:flutter/material.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/turf.dart';

class TurfCard extends StatelessWidget {
  const TurfCard({super.key, required this.turf, required this.onTap});
  final Turf turf;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder (real photos come with the API)
            Container(
              height: 130,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.brandGreen, AppColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Stack(children: [
                const Center(
                    child: Icon(Icons.sports_soccer, size: 48, color: Colors.white54)),
                PositionedDirectional(
                  top: AppSpacing.sm,
                  start: AppSpacing.sm,
                  child: _StatusChip(isOpen: turf.isOpen),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                      child: Text(turf.name,
                          style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                    ),
                    const Icon(Icons.star, size: 18, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text(turf.rating.toStringAsFixed(1)),
                  ]),
                  const SizedBox(height: AppSpacing.xs),
                  Row(children: [
                    const Icon(Icons.location_on_outlined,
                        size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(turf.area, style: const TextStyle(color: AppColors.textSecondary)),
                  ]),
                  const SizedBox(height: AppSpacing.sm),
                  Row(children: [
                    Wrap(
                      spacing: AppSpacing.xs,
                      children: [
                        for (final f in turf.formats)
                          Chip(
                            label: Text(f),
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                          ),
                      ],
                    ),
                    const Spacer(),
                    Text(l10n!.perHour(turf.pricePerHour),
                        style: theme.titleSmall?.copyWith(
                            color: AppColors.primary, fontWeight: FontWeight.w800)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.isOpen});
  final bool isOpen;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isOpen ? AppColors.available : AppColors.booked,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(isOpen ? context.l10n!.openNow : context.l10n!.closedNow,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
      );
}
