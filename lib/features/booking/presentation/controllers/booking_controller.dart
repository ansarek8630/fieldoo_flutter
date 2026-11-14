import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../turfs/domain/entities/turf.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/time_slot.dart';
import '../providers/booking_providers.dart';

class BookingState {
  const BookingState({
    required this.date,
    this.hour,
    this.duration = 1,
    this.isSubmitting = false,
  });
  final DateTime date;
  final int? hour;
  final int duration;
  final bool isSubmitting;

  BookingState copyWith({int? hour, int? duration, bool? isSubmitting}) => BookingState(
        date: date,
        hour: hour ?? this.hour,
        duration: duration ?? this.duration,
        isSubmitting: isSubmitting ?? this.isSubmitting,
      );
}

/// One controller per turf id; disposed when the booking page closes.
class BookingController extends AutoDisposeFamilyNotifier<BookingState, String> {
  @override
  BookingState build(String turfId) {
    final n = DateTime.now();
    return BookingState(date: DateTime(n.year, n.month, n.day));
  }

  /// Changing the day clears the chosen hour (availability differs per day).
  void selectDate(DateTime date) =>
      state = BookingState(date: date, duration: state.duration);

  void selectHour(int hour, List<TimeSlot> slots) {
    final fits = slots.canBook(hour, state.duration);
    state = state.copyWith(hour: hour, duration: fits ? state.duration : 1);
  }

  void setDuration(int duration) => state = state.copyWith(duration: duration);

  Future<Booking?> confirm(Turf turf) async {
    final hour = state.hour;
    if (hour == null || state.isSubmitting) return null;
    state = state.copyWith(isSubmitting: true);
    try {
      return await ref.read(createBookingUseCaseProvider).call(
            turfId: turf.id,
            date: state.date,
            startHour: hour,
            durationHours: state.duration,
            pricePerHour: turf.pricePerHour,
          );
    } catch (_) {
      return null;
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }
}

final bookingControllerProvider = NotifierProvider.autoDispose
    .family<BookingController, BookingState, String>(BookingController.new);
