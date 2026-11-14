import '../entities/open_match.dart';
import '../repositories/match_repository.dart';

class GetOpenMatchesUseCase {
  const GetOpenMatchesUseCase(this._repo);
  final MatchRepository _repo;

  /// Soonest first.
  Future<List<OpenMatch>> call() async {
    final list = await _repo.getOpenMatches();
    return [...list]..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }
}
