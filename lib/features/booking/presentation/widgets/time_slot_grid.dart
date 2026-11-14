import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/time_slot.dart';
import 'slot_chip.dart';

class TimeSlotGrid extends StatelessWidget {
  const TimeSlotGrid({
    super.key,
    required this.slots,
    required this.selectedHour,
    required this.duration,
    required this.onSelect,
  });
  final List<TimeSlot> slots;
  final int? selectedHour;
  final int duration;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    bool inSelection(int h) =>
        selectedHour != null && h >= selectedHour! && h < selectedHour! + duration;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final s in slots)
          SlotChip(
            label: DateFormat.j(locale).format(DateTime(2000, 1, 1, s.hour)),
            visual: s.isBooked
                ? SlotVisual.booked
                : inSelection(s.hour)
                    ? SlotVisual.selected
                    : SlotVisual.available,
            onTap: () => onSelect(s.hour),
          ),
      ],
    );
  }
}
