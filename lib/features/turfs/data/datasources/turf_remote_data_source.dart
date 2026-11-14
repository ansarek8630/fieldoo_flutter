import '../../domain/entities/amenity.dart';
import '../../domain/entities/turf.dart';

abstract interface class TurfRemoteDataSource {
  Future<List<Turf>> fetchTurfs();
  Future<Turf?> fetchTurfById(String id);
}

/// Mock data until the real API exists.
class FakeTurfRemoteDataSource implements TurfRemoteDataSource {
  static const _turfs = [
    Turf(id: 't1', name: 'Al Barsha Arena', area: 'Al Barsha', pricePerHour: 280, rating: 4.7, formats: ['5v5', '7v7'], isOpen: true,
        amenities: [Amenity.parking, Amenity.floodlights, Amenity.changingRooms, Amenity.water]),
    Turf(id: 't2', name: 'Green Park Turf', area: 'Dubai Sports City', pricePerHour: 350, rating: 4.5, formats: ['7v7', '9v9'], isOpen: true,
        opensAt: 7, closesAt: 23, amenities: [Amenity.parking, Amenity.floodlights, Amenity.showers, Amenity.cafe, Amenity.wifi]),
    Turf(id: 't3', name: 'Marina Kickoff', area: 'Dubai Marina', pricePerHour: 400, rating: 4.8, formats: ['5v5'], isOpen: false,
        opensAt: 8, closesAt: 22, amenities: [Amenity.floodlights, Amenity.changingRooms, Amenity.showers, Amenity.cafe]),
    Turf(id: 't4', name: 'Mirdif Pitch', area: 'Mirdif', pricePerHour: 240, rating: 4.2, formats: ['5v5', '7v7'], isOpen: true,
        amenities: [Amenity.parking, Amenity.floodlights, Amenity.water]),
    Turf(id: 't5', name: 'Jumeirah Goal Zone', area: 'Jumeirah', pricePerHour: 320, rating: 4.6, formats: ['7v7'], isOpen: true,
        opensAt: 6, closesAt: 23, amenities: [Amenity.parking, Amenity.floodlights, Amenity.changingRooms, Amenity.showers, Amenity.wifi]),
  ];

  @override
  Future<List<Turf>> fetchTurfs() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return _turfs;
  }

  @override
  Future<Turf?> fetchTurfById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    for (final t in _turfs) {
      if (t.id == id) return t;
    }
    return null;
  }
}
