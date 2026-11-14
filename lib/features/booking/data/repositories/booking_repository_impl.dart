import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_data_source.dart';

class BookingRepositoryImpl implements BookingRepository {
  const BookingRepositoryImpl(this._remote);
  final BookingRemoteDataSource _remote;

  @override
  Future<Set<int>> getBookedHours(String turfId, DateTime date) =>
      _remote.fetchBookedHours(turfId, date);

  @override
  Future<Booking> createBooking({
    required String turfId,
    required DateTime date,
    required int startHour,
    required int durationHours,
    required int totalPrice,
  }) =>
      _remote.postBooking(
        turfId: turfId,
        date: date,
        startHour: startHour,
        durationHours: durationHours,
        totalPrice: totalPrice,
      );
}
