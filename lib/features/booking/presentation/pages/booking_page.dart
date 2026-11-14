import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../turfs/domain/entities/turf.dart';
import '../../../turfs/presentation/providers/turf_providers.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/time_slot.dart';
import '../controllers/booking_controller.dart';
import '../providers/booking_providers.dart';
import '../widgets/booking_summary_bar.dart';
import '../widgets/date_strip.dart';
import '../widgets/duration_selector.dart';
import '../widgets/slot_legend.dart';
import '../widgets/time_slot_grid.dart';

class BookingPage extends ConsumerWidget {
  const BookingPage({super.key, required this.turfId});
  final String turfId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final turf = ref.watch(turfDetailsProvider(turfId));
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n!.bookingTitle)),
      body: turf.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) =>
            ErrorView(onRetry: () => ref.invalidate(turfDetailsProvider(turfId))),
        data: (t) => t == null
            ? Center(child: Text(context.l10n!.turfNotFound))
            : _BookingBody(turf: t),
      ),
    );
  }
}

class _BookingBody extends ConsumerWidget {
  const _BookingBody({required this.turf});
  final Turf turf;

  Future<void> _confirm(BuildContext context, WidgetRef ref) async {
    final booking = await ref.read(bookingControllerProvider(turf.id).notifier).confirm(turf);
    if (!context.mounted) return;
    if (booking == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l10n!.bookingFailed)));
      return;
    }
    await _showSuccess(context, booking);
    if (context.mounted) context.go('/home');
  }

  Future<void> _showSuccess(BuildContext context, Booking b) {
    final l = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: AppColors.available, size: 56),
        title: Text(l!.bookingConfirmed, textAlign: TextAlign.center),
        content: Text(
          l.bookingConfirmedMsg(
            turf.name,
            DateFormat.MMMEd(locale).format(b.date),
            DateFormat.j(locale).format(DateTime(2000, 1, 1, b.startHour)),
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(onPressed: () => Navigator.pop(ctx), child: Text(l.done)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final state = ref.watch(bookingControllerProvider(turf.id));
    final controller = ref.read(bookingControllerProvider(turf.id).notifier);
    final slots = ref.watch(timeSlotsProvider((turfId: turf.id, date: state.date)));
    final list = slots.valueOrNull ?? const <TimeSlot>[];
    final hour = state.hour;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(turf.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w800)),
                SectionTitle(l!.selectDate),
                DateStrip(selected: state.date, onSelected: controller.selectDate),
                SectionTitle(l.selectTime),
                slots.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (_, __) => ErrorView(
                      onRetry: () => ref.invalidate(
                          timeSlotsProvider((turfId: turf.id, date: state.date)))),
                  data: (s) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TimeSlotGrid(
                        slots: s,
                        selectedHour: hour,
                        duration: state.duration,
                        onSelect: (h) => controller.selectHour(h, s),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const SlotLegend(),
                    ],
                  ),
                ),
                SectionTitle(l.duration),
                DurationSelector(
                  value: state.duration,
                  canFit: (d) => hour == null || list.canBook(hour, d),
                  onChanged: controller.setDuration,
                ),
              ],
            ),
          ),
        ),
        BookingSummaryBar(
          totalPrice: turf.pricePerHour * state.duration,
          canConfirm: hour != null,
          isLoading: state.isSubmitting,
          onConfirm: () => _confirm(context, ref),
        ),
      ],
    );
  }
}
