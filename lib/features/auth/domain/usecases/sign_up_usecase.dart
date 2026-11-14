import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  const SignUpUseCase(this._repo);
  final AuthRepository _repo;

  Future<AppUser> call({
    required String name,
    required String email,
    required String password,
    String? photoPath,
  }) =>
      _repo.signUp(
          name: name.trim(), email: email.trim(), password: password, photoPath: photoPath);
}
