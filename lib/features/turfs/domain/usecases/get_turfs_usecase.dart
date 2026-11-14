import '../entities/turf.dart';
import '../repositories/turf_repository.dart';

class GetTurfsUseCase {
  const GetTurfsUseCase(this._repo);
  final TurfRepository _repo;
  Future<List<Turf>> call() => _repo.getTurfs();
}
