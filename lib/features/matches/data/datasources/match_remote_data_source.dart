import '../../domain/entities/open_match.dart';

abstract interface class MatchRemoteDataSource {
  Future<List<OpenMatch>> fetchOpenMatches();
  Future<OpenMatch> postJoin(String matchId);
}

/// In-memory fake: joins persist while the app runs.
class FakeMatchRemoteDataSource implements MatchRemoteDataSource {
  late final List<OpenMatch> _matches = _seed();

  static List<OpenMatch> _seed() {
    final n = DateTime.now();
    DateTime at(int days, int hour) => DateTime(n.year, n.month, n.day + days, hour);
    return [
      OpenMatch(id: 'm1', turfName: 'Al Barsha Arena', area: 'Al Barsha', dateTime: at(0, 21), format: '5v5', skill: SkillLevel.intermediate, playersJoined: 7, maxPlayers: 10, pricePerPlayer: 30, hostName: 'Ahmed'),
      OpenMatch(id: 'm2', turfName: 'Green Park Turf', area: 'Dubai Sports City', dateTime: at(1, 20), format: '7v7', skill: SkillLevel.beginner, playersJoined: 12, maxPlayers: 14, pricePerPlayer: 28, hostName: 'Sara'),
      OpenMatch(id: 'm3', turfName: 'Marina Kickoff', area: 'Dubai Marina', dateTime: at(1, 19), format: '5v5', skill: SkillLevel.advanced, playersJoined: 10, maxPlayers: 10, pricePerPlayer: 40, hostName: 'Omar'),
      OpenMatch(id: 'm4', turfName: 'Mirdif Pitch', area: 'Mirdif', dateTime: at(2, 22), format: '5v5', skill: SkillLevel.beginner, playersJoined: 4, maxPlayers: 10, pricePerPlayer: 24, hostName: 'Khalid'),
      OpenMatch(id: 'm5', turfName: 'Jumeirah Goal Zone', area: 'Jumeirah', dateTime: at(3, 18), format: '7v7', skill: SkillLevel.intermediate, playersJoined: 9, maxPlayers: 14, pricePerPlayer: 32, hostName: 'Layla'),
      OpenMatch(id: 'm6', turfName: 'Green Park Turf', area: 'Dubai Sports City', dateTime: at(4, 21), format: '9v9', skill: SkillLevel.advanced, playersJoined: 11, maxPlayers: 18, pricePerPlayer: 35, hostName: 'Yusuf'),
    ];
  }

  @override
  Future<List<OpenMatch>> fetchOpenMatches() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return List.of(_matches);
  }

  @override
  Future<OpenMatch> postJoin(String matchId) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    final i = _matches.indexWhere((m) => m.id == matchId);
    if (i < 0 || _matches[i].isFull) throw StateError('Match unavailable');
    final m = _matches[i];
    return _matches[i] = m.copyWith(playersJoined: m.playersJoined + 1, hasJoined: true);
  }
}
