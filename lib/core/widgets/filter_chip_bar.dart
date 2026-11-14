import 'package:flutter/material.dart';
import '../extensions/context_x.dart';

/// Horizontal single-select chips with an "All" option (selected == null).
class FilterChipBar<T> extends StatelessWidget {
  const FilterChipBar({
    super.key,
    required this.options,
    required this.selected,
    required this.labelOf,
    required this.onChanged,
  });
  final List<T> options;
  final T? selected;
  final String Function(T) labelOf;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            _chip(context.l10n!.allFilter, selected == null, () => onChanged(null)),
            for (final o in options)
              _chip(labelOf(o), selected == o, () => onChanged(o)),
          ],
        ),
      );

  Widget _chip(String label, bool isSelected, VoidCallback onTap) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 8),
        child: ChoiceChip(label: Text(label), selected: isSelected, onSelected: (_) => onTap()),
      );
}
