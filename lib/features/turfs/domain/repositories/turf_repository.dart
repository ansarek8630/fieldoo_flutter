import '../entities/turf.dart';

abstract interface class TurfRepository {
  Future<List<Turf>> getTurfs();
}
