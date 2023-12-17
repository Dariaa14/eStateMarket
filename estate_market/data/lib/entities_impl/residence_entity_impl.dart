import 'package:domain/entities/residence_entity.dart';

import 'property_entity_impl.dart';

class ResidenceEntityImpl extends PropertyEntityImpl implements ResidenceEntity {
  @override
  int numberOfRooms;

  @override
  int numberOfBathrooms;

  @override
  FurnishingLevel furnishingLevel;

  ResidenceEntityImpl(
      {required this.numberOfRooms,
      required this.numberOfBathrooms,
      required this.furnishingLevel,
      required double surface,
      required double price,
      required bool isNegotiable,
      int? constructionYear})
      : super(surface: surface, price: price, isNegotiable: isNegotiable, constructionYear: constructionYear);
}
