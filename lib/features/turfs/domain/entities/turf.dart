class Turf {
  const Turf({
    required this.id,
    required this.name,
    required this.area,
    required this.pricePerHour,
    required this.rating,
    required this.formats,
    required this.isOpen,
  });
  final String id;
  final String name;
  final String area;
  final int pricePerHour;
  final double rating;
  final List<String> formats; // e.g. 5v5, 7v7
  final bool isOpen;
}
