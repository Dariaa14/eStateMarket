import 'package:domain/entities/residence_entity.dart';

enum Partitioning { selfContained, semiSelfContained, nonSelfContained, circular }

abstract class ApartmentEntity extends ResidenceEntity {
  final Partitioning partitioning;
  final int floor;

  ApartmentEntity(
      {required this.partitioning,
      required this.floor,
      required super.constructionYear,
      required super.numberOfRooms,
      required super.numberOfBathrooms,
      required super.furnishingLevel,
      required super.surface,
      required super.price,
      required super.isNegotiable});
}
