import 'package:domain/entities/property_entity.dart';

enum FurnishingLevel { furnished, semiFurnished, unfurnished }

abstract class ResidenceEntity extends PropertyEntity {
  final int numberOfRooms;
  final int numberOfBathrooms;
  final FurnishingLevel furnishingLevel;

  ResidenceEntity(
      {required this.numberOfRooms,
      required this.numberOfBathrooms,
      required this.furnishingLevel,
      required super.surface,
      required super.price,
      required super.isNegotiable,
      required super.constructionYear});
}
