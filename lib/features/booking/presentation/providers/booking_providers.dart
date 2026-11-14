import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../turfs/presentation/providers/turf_providers.dart';
import '../../data/datasources/booking_remote_data_source.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../../domain/entities/time_slot.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../domain/usecases/create_booking_usecase.dart';
import '../../domain/usecases/get_time_slots_usecase.dart';

// DI graph: datasource -> repository -> usecases
final bookingRemoteDataSourceProvider =
    Provider<BookingRemoteDataSource>((ref) => FakeBookingRemoteDataSource());
final bookingRepositoryProvider = Provider<BookingRepository>(
    (ref) => BookingRepositoryImpl(ref.watch(bookingRemoteDataSourceProvider)));
final getTimeSlotsUseCaseProvider = Provider<GetTimeSlotsUseCase>(
    (ref) => GetTimeSlotsUseCase(ref.watch(bookingRepositoryProvider)));
final createBookingUseCaseProvider = Provider<CreateBookingUseCase>(
    (ref) => CreateBookingUseCase(ref.watch(bookingRepositoryProvider)));

typedef SlotsArgs = ({String turfId, DateTime date});

/// Slots for one turf on one day (date must be date-only).
final timeSlotsProvider =
    FutureProvider.autoDispose.family<List<TimeSlot>, SlotsArgs>((ref, args) async {
  final turf = await ref.watch(turfDetailsProvider(args.turfId).future);
  if (turf == null) return const [];
  return ref.watch(getTimeSlotsUseCaseProvider).call(
        turfId: args.turfId,
        date: args.date,
        opensAt: turf.opensAt,
        closesAt: turf.closesAt,
      );
});
