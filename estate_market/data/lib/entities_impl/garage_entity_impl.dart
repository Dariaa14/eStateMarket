import 'package:domain/entities/garage_entity.dart';

import 'property_entity_impl.dart';

class GarageEntityImpl extends PropertyEntityImpl implements GarageEntity {
  @override
  int capacity;

  @override
  ParkingType parkingType;

  GarageEntityImpl(
      {required this.parkingType,
      required this.capacity,
      required double surface,
      required double price,
      required bool isNegotiable,
      int? constructionYear})
      : super(surface: surface, price: price, isNegotiable: isNegotiable, constructionYear: constructionYear);

  @override
  Map<String, dynamic> toJson() {
    final json = {
      'surface': surface,
      'price': price,
      'isNegotiable': isNegotiable,
      'capacity': capacity,
      'parkingType': parkingType.index
    };
    if (constructionYear != null) {
      json.addAll({'constructionYear': constructionYear!});
    }
    return json;
  }

  factory GarageEntityImpl.fromJson(Map<String, Object?> json) {
    return GarageEntityImpl(
      surface: (json['surface'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      isNegotiable: json['isNegotiable'] as bool,
      capacity: (json['capacity'] as num).toInt(),
      parkingType: ParkingType.values[json['parkingType'] as int],
      constructionYear: (json.containsKey('constructionYear')) ? json['constructionYear'] as int : null,
    );
  }
}
