import '../entities/turf.dart';
import '../repositories/turf_repository.dart';

class GetTurfByIdUseCase {
  const GetTurfByIdUseCase(this._repo);
  final TurfRepository _repo;
  Future<Turf?> call(String id) => _repo.getTurfById(id);
}
