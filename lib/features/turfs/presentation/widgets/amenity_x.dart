import 'package:flutter/material.dart';
import '../../../../core/extensions/context_x.dart';
import '../../domain/entities/amenity.dart';

/// UI mapping for the domain enum (keeps the domain layer Flutter-free).
extension AmenityX on Amenity {
  IconData get icon => switch (this) {
        Amenity.parking => Icons.local_parking,
        Amenity.floodlights => Icons.light_mode_outlined,
        Amenity.changingRooms => Icons.checkroom_outlined,
        Amenity.showers => Icons.shower_outlined,
        Amenity.cafe => Icons.local_cafe_outlined,
        Amenity.wifi => Icons.wifi,
        Amenity.water => Icons.water_drop_outlined,
      };

  String label(BuildContext context) {
    final l = context.l10n;
    return switch (this) {
      Amenity.parking => l!.amenityParking,
      Amenity.floodlights => l!.amenityFloodlights,
      Amenity.changingRooms => l!.amenityChangingRooms,
      Amenity.showers => l!.amenityShowers,
      Amenity.cafe => l!.amenityCafe,
      Amenity.wifi => l!.amenityWifi,
      Amenity.water => l!.amenityWater,
    };
  }
}
