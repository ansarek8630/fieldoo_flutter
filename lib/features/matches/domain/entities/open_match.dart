enum SkillLevel { beginner, intermediate, advanced }

class OpenMatch {
  const OpenMatch({
    required this.id,
    required this.turfName,
    required this.area,
    required this.dateTime,
    required this.format,
    required this.skill,
    required this.playersJoined,
    required this.maxPlayers,
    required this.pricePerPlayer,
    required this.hostName,
    this.hasJoined = false,
  });
  final String id;
  final String turfName;
  final String area;
  final DateTime dateTime;
  final String format; // 5v5, 7v7...
  final SkillLevel skill;
  final int playersJoined;
  final int maxPlayers;
  final int pricePerPlayer;
  final String hostName;
  final bool hasJoined;

  int get spotsLeft => maxPlayers - playersJoined;
  bool get isFull => spotsLeft <= 0;

  OpenMatch copyWith({int? playersJoined, bool? hasJoined}) => OpenMatch(
        id: id,
        turfName: turfName,
        area: area,
        dateTime: dateTime,
        format: format,
        skill: skill,
        playersJoined: playersJoined ?? this.playersJoined,
        maxPlayers: maxPlayers,
        pricePerPlayer: pricePerPlayer,
        hostName: hostName,
        hasJoined: hasJoined ?? this.hasJoined,
      );
}
