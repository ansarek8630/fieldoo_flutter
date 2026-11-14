import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/language_toggle.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/turf_providers.dart';
import '../widgets/turf_card.dart';

class TurfListPage extends ConsumerWidget {
  const TurfListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final turfs = ref.watch(filteredTurfsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.turfsNearYou),
        actions: const [LanguageToggle(color: AppColors.white)],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: AppSearchField(
              hint: l10n.searchTurfs,
              onChanged: (v) => ref.read(turfSearchProvider.notifier).state = v,
            ),
          ),
          Expanded(
            child: turfs.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => ErrorView(onRetry: () => ref.invalidate(turfListProvider)),
              data: (list) => list.isEmpty
                  ? Center(child: Text(l10n.noTurfsFound))
                  : RefreshIndicator(
                      onRefresh: () async => ref.invalidate(turfListProvider),
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                            AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
                        itemCount: list.length,
                        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
                        itemBuilder: (_, i) => TurfCard(
                          turf: list[i],
                          onTap: () {}, // Turf details route arrives in the next step
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
