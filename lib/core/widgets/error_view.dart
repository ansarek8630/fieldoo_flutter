import 'package:flutter/material.dart';
import '../extensions/context_x.dart';
import '../theme/app_colors.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: 8),
          Text(context.l10n!.loadFailed),
          TextButton(onPressed: onRetry, child: Text(context.l10n!.retry)),
        ]),
      );
}
