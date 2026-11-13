import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/context_x.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/logo_mark.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2200), () {
      if (mounted) context.go('/sign-in');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.brandGreen,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LogoMark(size: 120),
            const SizedBox(height: 16),
            Text(l10n!.appName,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(l10n.tagline,
                style: const TextStyle(color: Colors.white70, fontSize: 18, letterSpacing: 1.2)),
          ],
        ),
      ),
    );
  }
}
