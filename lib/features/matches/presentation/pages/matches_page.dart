import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/filter_chip_bar.dart';
import '../../../../core/widgets/language_toggle.dart';
import '../../domain/entities/open_match.dart';
import '../controllers/open_matches_controller.dart';
import '../providers/match_providers.dart';
import '../widgets/match_card.dart';
import '../widgets/skill_level_x.dart';

class MatchesPage extends ConsumerWidget {
  const MatchesPage({super.key});

  static const _formats = ['5v5', '7v7', '9v9'];

  Future<void> _join(BuildContext context, WidgetRef ref, String id) async {
    final ok = await ref.read(openMatchesProvider.notifier).join(id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ok ? context.l10n!.joinSuccess : context.l10n!.joinFailed)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final matches = ref.watch(filteredMatchesProvider);
    final joining = ref.watch(joiningMatchIdsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l!.matchesTitle),
        actions: const [LanguageToggle(color: AppColors.white)],
      ),
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.sm),
          FilterChipBar<String>(
            options: _formats,
            selected: ref.watch(matchFormatFilterProvider),
            labelOf: (f) => f,
            onChanged: (v) => ref.read(matchFormatFilterProvider.notifier).state = v,
          ),
          const SizedBox(height: AppSpacing.xs),
          FilterChipBar<SkillLevel>(
            options: SkillLevel.values,
            selected: ref.watch(matchSkillFilterProvider),
            labelOf: (s) => s.label(context),
            onChanged: (v) => ref.read(matchSkillFilterProvider.notifier).state = v,
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: matches.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => ErrorView(onRetry: () => ref.invalidate(openMatchesProvider)),
              data: (list) => list.isEmpty
                  ? Center(child: Text(l.noMatches))
                  : RefreshIndicator(
                      onRefresh: () async => ref.invalidate(openMatchesProvider),
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                            AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.md),
                        itemCount: list.length,
                        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
                        itemBuilder: (_, i) => MatchCard(
                          match: list[i],
                          isJoining: joining.contains(list[i].id),
                          onJoin: () => _join(context, ref, list[i].id),
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
