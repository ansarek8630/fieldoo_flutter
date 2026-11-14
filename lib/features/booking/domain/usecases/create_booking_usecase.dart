import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class CreateBookingUseCase {
  const CreateBookingUseCase(this._repo);
  final BookingRepository _repo;

  Future<Booking> call({
    required String turfId,
    required DateTime date,
    required int startHour,
    required int durationHours,
    required int pricePerHour,
  }) =>
      _repo.createBooking(
        turfId: turfId,
        date: date,
        startHour: startHour,
        durationHours: durationHours,
        totalPrice: pricePerHour * durationHours,
      );
}
