import '../entities/open_match.dart';

abstract interface class MatchRepository {
  Future<List<OpenMatch>> getOpenMatches();
  Future<OpenMatch> joinMatch(String matchId);
}
