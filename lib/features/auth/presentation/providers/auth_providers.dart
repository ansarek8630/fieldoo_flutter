import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

// Dependency injection graph: datasource -> repository -> usecase.
final authRemoteDataSourceProvider =
    Provider<AuthRemoteDataSource>((ref) => FakeAuthRemoteDataSource());

final authRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider)));

final signInUseCaseProvider = Provider<SignInUseCase>(
    (ref) => SignInUseCase(ref.watch(authRepositoryProvider)));

final signUpUseCaseProvider = Provider<SignUpUseCase>(
    (ref) => SignUpUseCase(ref.watch(authRepositoryProvider)));
