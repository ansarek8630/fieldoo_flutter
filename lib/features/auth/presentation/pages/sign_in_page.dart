import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/language_toggle.dart';
import '../../../../core/widgets/logo_mark.dart';
import '../controllers/sign_in_controller.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});
  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await ref
        .read(signInControllerProvider.notifier)
        .submit(_email.text, _password.text);
    if (!mounted) return;
    if (ok) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l10n!.signInFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final loading = ref.watch(signInControllerProvider).isLoading;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(AppSpacing.md,
                MediaQuery.of(context).padding.top + AppSpacing.sm, AppSpacing.md, AppSpacing.xl),
            decoration: const BoxDecoration(
              color: AppColors.brandGreen,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            child: Column(
              children: [
                const Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: LanguageToggle(color: AppColors.white),
                ),
                const LogoMark(size: 72),
                const SizedBox(height: AppSpacing.sm),
                Text(l10n!.appName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.white, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n!.welcomeBack,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: AppSpacing.xs),
                    Text(l10n.signInSubtitle,
                        style: const TextStyle(color: AppColors.textSecondary)),
                    const SizedBox(height: AppSpacing.lg),
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
                      validator: (v) =>
                          (v == null || v.length < 6) ? l10n.passwordShort : null,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(label: l10n.signIn, onPressed: _submit, isLoading: loading),
                    const SizedBox(height: AppSpacing.sm),
                    Center(
                      child: TextButton(
                        onPressed: () => context.go('/home'),
                        child: Text(l10n.continueAsGuest),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(l10n.noAccount),
                        TextButton(onPressed: () {}, child: Text(l10n.createAccount)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
