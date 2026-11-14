import 'package:flutter/material.dart';
import '../../../../core/extensions/context_x.dart';
import '../../domain/entities/open_match.dart';

extension SkillLevelX on SkillLevel {
  String label(BuildContext context) {
    final l = context.l10n;
    return switch (this) {
      SkillLevel.beginner => l!.skillBeginner,
      SkillLevel.intermediate => l!.skillIntermediate,
      SkillLevel.advanced => l!.skillAdvanced,
    };
  }
}
