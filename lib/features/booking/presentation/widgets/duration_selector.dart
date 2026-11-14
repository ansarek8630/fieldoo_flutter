import 'package:flutter/material.dart';
import '../../../../core/extensions/context_x.dart';

class DurationSelector extends StatelessWidget {
  const DurationSelector({
    super.key,
    required this.value,
    required this.canFit,
    required this.onChanged,
    this.options = const [1, 2, 3],
  });
  final int value;
  final bool Function(int duration) canFit;
  final ValueChanged<int> onChanged;
  final List<int> options;

  @override
  Widget build(BuildContext context) => SegmentedButton<int>(
        showSelectedIcon: false,
        segments: [
          for (final d in options)
            ButtonSegment(
                value: d, label: Text(context.l10n!.hoursCount(d)), enabled: canFit(d)),
        ],
        selected: {value},
        onSelectionChanged: (s) => onChanged(s.first),
      );
}
