import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

class SignInController extends AutoDisposeAsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> submit(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(signInUseCaseProvider).call(email, password));
    return !state.hasError;
  }
}

final signInControllerProvider =
    AsyncNotifierProvider.autoDispose<SignInController, void>(SignInController.new);
