import 'package:domain/entities/property_entity.dart';

enum ParkingType {
  interiorParking,
  exteriorParking,
  garage,
}

abstract class GarageEntity extends PropertyEntity {
  final ParkingType parkingType;
  final int capacity;
  // security

  GarageEntity(
      {required this.parkingType,
      required this.capacity,
      required super.surface,
      required super.price,
      required super.isNegotiable});
}
