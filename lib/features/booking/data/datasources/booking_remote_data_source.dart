import '../../domain/entities/booking.dart';

abstract interface class BookingRemoteDataSource {
  Future<Set<int>> fetchBookedHours(String turfId, DateTime date);
  Future<Booking> postBooking({
    required String turfId,
    required DateTime date,
    required int startHour,
    required int durationHours,
    required int totalPrice,
  });
}

/// Deterministic fake: a few evening hours look booked, varying by day and turf.
class FakeBookingRemoteDataSource implements BookingRemoteDataSource {
  @override
  Future<Set<int>> fetchBookedHours(String turfId, DateTime date) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final seed = date.day + turfId.hashCode.abs() % 7;
    return {18 + seed % 3, 20 + seed % 2, 9 + seed % 4, 14 + seed % 3};
  }

  @override
  Future<Booking> postBooking({
    required String turfId,
    required DateTime date,
    required int startHour,
    required int durationHours,
    required int totalPrice,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    return Booking(
      id: 'b${DateTime.now().millisecondsSinceEpoch}',
      turfId: turfId,
      date: date,
      startHour: startHour,
      durationHours: durationHours,
      totalPrice: totalPrice,
    );
  }
}
