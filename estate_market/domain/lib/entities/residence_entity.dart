import 'package:domain/entities/property_entity.dart';

abstract class ResidenceEntity extends PropertyEntity {
  final int numberOfRooms;
  final int numberOfBathrooms;
  final bool isFurnished;

  ResidenceEntity(
      {required this.numberOfRooms,
      required this.numberOfBathrooms,
      required this.isFurnished,
      required super.surface,
      required super.price,
      required super.isNegotiable});
}
