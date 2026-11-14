import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/image_picker_service.dart';
import '../providers/auth_providers.dart';

class SignUpState {
  const SignUpState({this.photoPath, this.isLoading = false});
  final String? photoPath;
  final bool isLoading;

  SignUpState copyWith({String? photoPath, bool? isLoading}) => SignUpState(
      photoPath: photoPath ?? this.photoPath, isLoading: isLoading ?? this.isLoading);
}

class SignUpController extends AutoDisposeNotifier<SignUpState> {
  @override
  SignUpState build() => const SignUpState();

  Future<void> pickPhoto({required bool camera}) async {
    final path = await ref.read(imagePickerServiceProvider).pick(camera: camera);
    if (path != null) state = state.copyWith(photoPath: path);
  }

  Future<bool> submit(String name, String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      await ref.read(signUpUseCaseProvider).call(
          name: name, email: email, password: password, photoPath: state.photoPath);
      return true;
    } catch (_) {
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final signUpControllerProvider =
    NotifierProvider.autoDispose<SignUpController, SignUpState>(SignUpController.new);
