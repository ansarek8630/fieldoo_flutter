import '../entities/open_match.dart';
import '../repositories/match_repository.dart';

class JoinMatchUseCase {
  const JoinMatchUseCase(this._repo);
  final MatchRepository _repo;
  Future<OpenMatch> call(String matchId) => _repo.joinMatch(matchId);
}
