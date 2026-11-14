import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/open_match.dart';
import '../providers/match_providers.dart';

class OpenMatchesController extends AsyncNotifier<List<OpenMatch>> {
  @override
  Future<List<OpenMatch>> build() => ref.watch(getOpenMatchesUseCaseProvider).call();

  /// Returns true when the join succeeded.
  Future<bool> join(String matchId) async {
    final joining = ref.read(joiningMatchIdsProvider.notifier);
    joining.update((s) => {...s, matchId});
    try {
      final updated = await ref.read(joinMatchUseCaseProvider).call(matchId);
      final current = state.valueOrNull ?? const <OpenMatch>[];
      state = AsyncData([for (final m in current) m.id == updated.id ? updated : m]);
      return true;
    } catch (_) {
      return false;
    } finally {
      joining.update((s) => {...s}..remove(matchId));
    }
  }
}

final openMatchesProvider =
    AsyncNotifierProvider<OpenMatchesController, List<OpenMatch>>(OpenMatchesController.new);

/// Matches after applying the format + skill filters.
final filteredMatchesProvider = Provider<AsyncValue<List<OpenMatch>>>((ref) {
  final format = ref.watch(matchFormatFilterProvider);
  final skill = ref.watch(matchSkillFilterProvider);
  return ref.watch(openMatchesProvider).whenData((list) => [
        for (final m in list)
          if ((format == null || m.format == format) && (skill == null || m.skill == skill)) m,
      ]);
});
