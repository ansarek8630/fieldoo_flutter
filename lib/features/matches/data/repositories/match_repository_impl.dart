import '../../domain/entities/open_match.dart';
import '../../domain/repositories/match_repository.dart';
import '../datasources/match_remote_data_source.dart';

class MatchRepositoryImpl implements MatchRepository {
  const MatchRepositoryImpl(this._remote);
  final MatchRemoteDataSource _remote;

  @override
  Future<List<OpenMatch>> getOpenMatches() => _remote.fetchOpenMatches();

  @override
  Future<OpenMatch> joinMatch(String matchId) => _remote.postJoin(matchId);
}
