import 'package:data/entities_impl/residence_entity_impl.dart';
import 'package:domain/entities/house_entity.dart';
import 'package:domain/entities/residence_entity.dart';
import 'package:domain/entities/ad_entity.dart';

class HouseEntityImpl extends ResidenceEntityImpl implements HouseEntity {
  @override
  double insideSurface;

  @override
  int numberOfFloors;

  @override
  double outsideSurface;

  HouseEntityImpl(
      {required this.insideSurface,
      required this.outsideSurface,
      required this.numberOfFloors,
      int? constructionYear,
      required int numberOfRooms,
      required int numberOfBathrooms,
      required FurnishingLevel furnishingLevel,
      required double surface,
      required double price,
      required bool isNegotiable})
      : super(
            constructionYear: constructionYear,
            numberOfRooms: numberOfRooms,
            numberOfBathrooms: numberOfBathrooms,
            furnishingLevel: furnishingLevel,
            surface: surface,
            price: price,
            isNegotiable: isNegotiable);

  @override
  Map<String, dynamic> toJson() {
    final json = {
      'type': AdCategory.house.index,
      'insideSurface': insideSurface,
      'outsideSurface': outsideSurface,
      'numberOfFloors': numberOfFloors,
      'numberOfRooms': numberOfRooms,
      'numberOfBathrooms': numberOfBathrooms,
      'furnishingLevel': furnishingLevel.index,
      'price': price,
      'isNegotiable': isNegotiable,
    };
    if (constructionYear != null) {
      json.addAll({'constructionYear': constructionYear!});
    }
    return json;
  }

  factory HouseEntityImpl.fromJson(Map<String, Object?> json) {
    return HouseEntityImpl(
      insideSurface: (json['insideSurface'] as num).toDouble(),
      outsideSurface: (json['outsideSurface'] as num).toDouble(),
      numberOfFloors: (json['numberOfFloors'] as num).toInt(),
      numberOfRooms: (json['numberOfRooms'] as num).toInt(),
      numberOfBathrooms: (json['numberOfBathrooms'] as num).toInt(),
      furnishingLevel: FurnishingLevel.values[json['furnishingLevel'] as int],
      price: (json['price'] as num).toDouble(),
      isNegotiable: json['isNegotiable'] as bool,
      constructionYear: (json.containsKey('constructionYear')) ? json['constructionYear'] as int : null,
      surface: (json['insideSurface'] as num).toDouble() + (json['outsideSurface'] as num).toDouble(),
    );
  }
}
