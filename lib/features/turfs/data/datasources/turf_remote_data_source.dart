import '../../domain/entities/turf.dart';

abstract interface class TurfRemoteDataSource {
  Future<List<Turf>> fetchTurfs();
}

/// Mock data until the real API exists.
class FakeTurfRemoteDataSource implements TurfRemoteDataSource {
  @override
  Future<List<Turf>> fetchTurfs() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return const [
      Turf(id: 't1', name: 'Al Barsha Arena', area: 'Al Barsha', pricePerHour: 280, rating: 4.7, formats: ['5v5', '7v7'], isOpen: true),
      Turf(id: 't2', name: 'Green Park Turf', area: 'Dubai Sports City', pricePerHour: 350, rating: 4.5, formats: ['7v7', '9v9'], isOpen: true),
      Turf(id: 't3', name: 'Marina Kickoff', area: 'Dubai Marina', pricePerHour: 400, rating: 4.8, formats: ['5v5'], isOpen: false),
      Turf(id: 't4', name: 'Mirdif Pitch', area: 'Mirdif', pricePerHour: 240, rating: 4.2, formats: ['5v5', '7v7'], isOpen: true),
      Turf(id: 't5', name: 'Jumeirah Goal Zone', area: 'Jumeirah', pricePerHour: 320, rating: 4.6, formats: ['7v7'], isOpen: true),
    ];
  }
}
