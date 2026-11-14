class Booking {
  const Booking({
    required this.id,
    required this.turfId,
    required this.date,
    required this.startHour,
    required this.durationHours,
    required this.totalPrice,
  });
  final String id;
  final String turfId;
  final DateTime date;
  final int startHour;
  final int durationHours;
  final int totalPrice;
}
