import '../../domain/entities/app_user.dart';

abstract interface class AuthRemoteDataSource {
  Future<AppUser> signIn(String email, String password);
  Future<AppUser> signUp(String name, String email, String password, String? photoPath);
}

/// Fake backend so the UI flow works end-to-end. Swap for a real API later.
class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<AppUser> signIn(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    return AppUser(id: 'u1', email: email, name: email.split('@').first);
  }

  @override
  Future<AppUser> signUp(
      String name, String email, String password, String? photoPath) async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    return AppUser(id: 'u2', email: email, name: name, photoPath: photoPath);
  }
}
