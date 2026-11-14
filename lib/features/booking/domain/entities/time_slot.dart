class TimeSlot {
  const TimeSlot({required this.hour, required this.isBooked});
  final int hour; // 0-23
  final bool isBooked;
}

extension TimeSlotListX on List<TimeSlot> {
  /// True when every hour in [startHour, startHour + duration) exists and is free.
  bool canBook(int startHour, int duration) {
    for (var h = startHour; h < startHour + duration; h++) {
      final slot = where((s) => s.hour == h);
      if (slot.isEmpty || slot.first.isBooked) return false;
    }
    return true;
  }
}
