import 'package:fieldoo_flutter/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/section_title.dart';
import '../../domain/entities/turf.dart';
import '../providers/turf_providers.dart';
import '../widgets/amenity_chip.dart';

class TurfDetailsPage extends ConsumerWidget {
  const TurfDetailsPage({super.key, required this.turfId});
  final String turfId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final turf = ref.watch(turfDetailsProvider(turfId));
    return Scaffold(
      body: turf.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) =>
            ErrorView(onRetry: () => ref.invalidate(turfDetailsProvider(turfId))),
        data: (t) => t == null
            ? Center(child: Text(context.l10n!.turfNotFound))
            : _Content(turf: t),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.turf});
  final Turf turf;

  String _hour(BuildContext context, int h) => DateFormat.j(
          Localizations.localeOf(context).toString())
      .format(DateTime(2000, 1, 1, h % 24));

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 220,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(turf.name),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColors.brandGreen, AppColors.primary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                    child: const Center(
                        child: Icon(Icons.sports_soccer, size: 72, color: Colors.white38)),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.md),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Row(children: [
                      const Icon(Icons.location_on_outlined,
                          size: 18, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(turf.area,
                            style: const TextStyle(color: AppColors.textSecondary)),
                      ),
                      const Icon(Icons.star, size: 20, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(turf.rating.toStringAsFixed(1),
                          style: text.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                    ]),
                    SectionTitle(l10n!.formats),
                    Wrap(spacing: AppSpacing.sm, children: [
                      for (final f in turf.formats) Chip(label: Text(f)),
                    ]),
                    SectionTitle(l10n!.openingHours),
                    Row(children: [
                      const Icon(Icons.schedule, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(l10n.hoursRange(
                          _hour(context, turf.opensAt), _hour(context, turf.closesAt))),
                    ]),
                    SectionTitle(l10n.amenities),
                    Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm, children: [
                      for (final a in turf.amenities) AmenityChip(amenity: a),
                    ]),
                    const SizedBox(height: AppSpacing.lg),
                  ]),
                ),
              ),
            ],
          ),
        ),
        // Sticky booking bar
        Material(
          elevation: 8,
          color: AppColors.white,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(l10n.priceLabel,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  Text(l10n.perHour(turf.pricePerHour),
                      style: text.titleMedium?.copyWith(
                          color: AppColors.primary, fontWeight: FontWeight.w800)),
                ]),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: AppButton(
                    label: l10n.bookNow,
                    // Booking page arrives in the next step.
                    onPressed: turf.isOpen
                        ? () => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(l10n.comingSoon)))
                        : null,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}

extension on AppLocalizations? {
  String? get formats => null;
}
