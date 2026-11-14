import '../entities/booking.dart';

abstract interface class BookingRepository {
  Future<Set<int>> getBookedHours(String turfId, DateTime date);
  Future<Booking> createBooking({
    required String turfId,
    required DateTime date,
    required int startHour,
    required int durationHours,
    required int totalPrice,
  });
}
