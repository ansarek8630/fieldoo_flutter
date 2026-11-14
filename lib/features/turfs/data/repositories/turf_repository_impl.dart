import '../../domain/entities/turf.dart';
import '../../domain/repositories/turf_repository.dart';
import '../datasources/turf_remote_data_source.dart';

class TurfRepositoryImpl implements TurfRepository {
  const TurfRepositoryImpl(this._remote);
  final TurfRemoteDataSource _remote;

  @override
  Future<List<Turf>> getTurfs() => _remote.fetchTurfs();
}
