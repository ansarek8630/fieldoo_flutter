import 'package:flutter/material.dart';
import '../extensions/context_x.dart';
import '../theme/app_colors.dart';

/// Temporary body for tabs that are built in later steps.
class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 56, color: AppColors.primary),
            const SizedBox(height: 12),
            Text(context.l10n!.comingSoon,
                style: const TextStyle(color: AppColors.textSecondary)),
          ]),
        ),
      );
}
