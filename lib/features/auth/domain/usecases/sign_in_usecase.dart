import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  const SignInUseCase(this._repo);
  final AuthRepository _repo;

  Future<AppUser> call(String email, String password) =>
      _repo.signIn(email: email.trim(), password: password);
}
