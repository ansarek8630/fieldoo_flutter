import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/turf_remote_data_source.dart';
import '../../data/repositories/turf_repository_impl.dart';
import '../../domain/entities/turf.dart';
import '../../domain/repositories/turf_repository.dart';
import '../../domain/usecases/get_turfs_usecase.dart';

// DI graph: datasource -> repository -> usecase
final turfRemoteDataSourceProvider =
    Provider<TurfRemoteDataSource>((ref) => FakeTurfRemoteDataSource());
final turfRepositoryProvider = Provider<TurfRepository>(
    (ref) => TurfRepositoryImpl(ref.watch(turfRemoteDataSourceProvider)));
final getTurfsUseCaseProvider = Provider<GetTurfsUseCase>(
    (ref) => GetTurfsUseCase(ref.watch(turfRepositoryProvider)));

final turfListProvider = FutureProvider.autoDispose<List<Turf>>(
    (ref) => ref.watch(getTurfsUseCaseProvider).call());

final turfSearchProvider = StateProvider.autoDispose<String>((ref) => '');

/// Turfs filtered by the search box (name or area).
final filteredTurfsProvider = Provider.autoDispose<AsyncValue<List<Turf>>>((ref) {
  final query = ref.watch(turfSearchProvider).trim().toLowerCase();
  return ref.watch(turfListProvider).whenData((list) => query.isEmpty
      ? list
      : list
          .where((t) =>
              t.name.toLowerCase().contains(query) || t.area.toLowerCase().contains(query))
          .toList());
});
