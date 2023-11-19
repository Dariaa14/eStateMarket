import 'package:domain/entities/residence_entity.dart';

abstract class HouseEntity extends ResidenceEntity {
  final double insideSurface;
  final double outsideSurface;
  final int numberOfFloors;

  HouseEntity(
      {required this.insideSurface,
      required this.outsideSurface,
      required this.numberOfFloors,
      required super.numberOfRooms,
      required super.numberOfBathrooms,
      required super.furnishingLevel,
      required super.surface,
      required super.price,
      required super.isNegotiable,
      required super.constructionYear});
}
