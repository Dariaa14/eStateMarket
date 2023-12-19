import 'package:data/entities_impl/residence_entity_impl.dart';
import 'package:domain/entities/apartment_entity.dart';
import 'package:domain/entities/residence_entity.dart';
import 'package:domain/entities/ad_entity.dart';

class ApartmentEntityImpl extends ResidenceEntityImpl implements ApartmentEntity {
  @override
  int floor;

  @override
  Partitioning partitioning;

  ApartmentEntityImpl(
      {required this.partitioning,
      required this.floor,
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
      'type': AdCategory.apartament.index,
      'partitioning': partitioning.index,
      'floor': floor,
      'numberOfRooms': numberOfRooms,
      'numberOfBathrooms': numberOfBathrooms,
      'furnishingLevel': furnishingLevel.index,
      'surface': surface,
      'price': price,
      'isNegotiable': isNegotiable,
    };
    if (constructionYear != null) {
      json.addAll({'constructionYear': constructionYear!});
    }
    return json;
  }

  factory ApartmentEntityImpl.fromJson(Map<String, Object?> json) {
    return ApartmentEntityImpl(
      partitioning: Partitioning.values[json['partitioning'] as int],
      floor: (json['floor'] as num).toInt(),
      numberOfRooms: (json['numberOfRooms'] as num).toInt(),
      numberOfBathrooms: (json['numberOfBathrooms'] as num).toInt(),
      furnishingLevel: FurnishingLevel.values[json['furnishingLevel'] as int],
      surface: (json['surface'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      isNegotiable: json['isNegotiable'] as bool,
      constructionYear: (json.containsKey('constructionYear')) ? json['constructionYear'] as int : null,
    );
  }
}
