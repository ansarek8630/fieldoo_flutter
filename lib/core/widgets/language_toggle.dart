import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../di/locale_provider.dart';
import '../extensions/context_x.dart';

class LanguageToggle extends ConsumerWidget {
  const LanguageToggle({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      onPressed: () => ref.read(localeProvider.notifier).toggle(),
      icon: Icon(Icons.language, color: color),
      label: Text(context.l10n!.language, style: TextStyle(color: color)),
    );
  }
}
