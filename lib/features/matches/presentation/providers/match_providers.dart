import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/match_remote_data_source.dart';
import '../../data/repositories/match_repository_impl.dart';
import '../../domain/entities/open_match.dart';
import '../../domain/repositories/match_repository.dart';
import '../../domain/usecases/get_open_matches_usecase.dart';
import '../../domain/usecases/join_match_usecase.dart';

// DI graph: datasource -> repository -> usecases
final matchRemoteDataSourceProvider =
    Provider<MatchRemoteDataSource>((ref) => FakeMatchRemoteDataSource());
final matchRepositoryProvider = Provider<MatchRepository>(
    (ref) => MatchRepositoryImpl(ref.watch(matchRemoteDataSourceProvider)));
final getOpenMatchesUseCaseProvider = Provider<GetOpenMatchesUseCase>(
    (ref) => GetOpenMatchesUseCase(ref.watch(matchRepositoryProvider)));
final joinMatchUseCaseProvider = Provider<JoinMatchUseCase>(
    (ref) => JoinMatchUseCase(ref.watch(matchRepositoryProvider)));

// Filters (null = All)
final matchFormatFilterProvider = StateProvider<String?>((ref) => null);
final matchSkillFilterProvider = StateProvider<SkillLevel?>((ref) => null);

/// Match ids with a join request in flight (drives per-card spinners).
final joiningMatchIdsProvider = StateProvider<Set<String>>((ref) => {});
