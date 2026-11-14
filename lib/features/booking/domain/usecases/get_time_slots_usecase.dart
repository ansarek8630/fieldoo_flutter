import '../entities/time_slot.dart';
import '../repositories/booking_repository.dart';

class GetTimeSlotsUseCase {
  const GetTimeSlotsUseCase(this._repo);
  final BookingRepository _repo;

  /// Builds the day's slots; hours already booked or in the past are unavailable.
  Future<List<TimeSlot>> call({
    required String turfId,
    required DateTime date,
    required int opensAt,
    required int closesAt,
    DateTime? now,
  }) async {
    final clock = now ?? DateTime.now();
    final booked = await _repo.getBookedHours(turfId, date);
    final isToday =
        date.year == clock.year && date.month == clock.month && date.day == clock.day;
    return [
      for (var h = opensAt; h < closesAt; h++)
        TimeSlot(hour: h, isBooked: booked.contains(h) || (isToday && h <= clock.hour)),
    ];
  }
}
