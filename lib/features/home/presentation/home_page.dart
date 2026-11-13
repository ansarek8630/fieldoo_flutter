import 'package:flutter/material.dart';
import '../../../core/extensions/context_x.dart';

/// Placeholder - replaced by the real Home/Turf list in the next step.
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(context.l10n!.appName)),
        body: Center(child: Text(context.l10n!.homePlaceholder)),
      );
}
