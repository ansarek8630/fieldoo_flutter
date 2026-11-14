import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/avatar_picker.dart';
import '../../../../core/widgets/language_toggle.dart';
import '../controllers/sign_up_controller.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});
  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _showPhotoSheet() {
    final l10n = context.l10n;
    final controller = ref.read(signUpControllerProvider.notifier);
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: Text(l10n!.takePhoto),
            onTap: () {
              Navigator.pop(ctx);
              controller.pickPhoto(camera: true);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: Text(l10n.chooseGallery),
            onTap: () {
              Navigator.pop(ctx);
              controller.pickPhoto(camera: false);
            },
          ),
        ]),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await ref
        .read(signUpControllerProvider.notifier)
        .submit(_name.text, _email.text, _password.text);
    if (!mounted) return;
    if (ok) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l10n!.accountCreateFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(signUpControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.createAccount),
        actions: const [LanguageToggle(color: AppColors.white)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.createAccountTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: AppSpacing.xs),
              Text(l10n.createAccountSubtitle,
                  style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: AppSpacing.lg),
              Center(
                child: Column(children: [
                  AvatarPicker(imagePath: state.photoPath, onTap: _showPhotoSheet),
                  TextButton(
                    onPressed: _showPhotoSheet,
                    child: Text(state.photoPath == null ? l10n.addPhoto : l10n.changePhoto),
                  ),
                ]),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: l10n.fullName,
                controller: _name,
                icon: Icons.person_outline,
                validator: (v) => (v == null || v.trim().isEmpty) ? l10n.nameRequired : null,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: l10n.email,
                controller: _email,
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return l10n.emailRequired;
                  if (!v.contains('@') || !v.contains('.')) return l10n.emailInvalid;
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: l10n.password,
                controller: _password,
                icon: Icons.lock_outline,
                obscure: true,
                validator: (v) => (v == null || v.length < 6) ? l10n.passwordShort : null,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: l10n.confirmPassword,
                controller: _confirm,
                icon: Icons.lock_reset,
                obscure: true,
                validator: (v) => v != _password.text ? l10n.passwordsMismatch : null,
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                  label: l10n.createAccount, onPressed: _submit, isLoading: state.isLoading),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.alreadyHaveAccount),
                  TextButton(
                      onPressed: () => context.go('/sign-in'), child: Text(l10n.signIn)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
