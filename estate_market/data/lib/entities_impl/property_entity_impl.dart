import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/property_entity.dart';

import 'terrain_entity_impl.dart';
import 'garage_entity_impl.dart';
import 'deposit_entity_impl.dart';
import 'apartment_entity_impl.dart';
import 'house_entity_impl.dart';

class PropertyEntityImpl implements PropertyEntity {
  static final propertyRef = FirebaseFirestore.instance.collection('properties').withConverter<PropertyEntity>(
        fromFirestore: (snapshots, _) => PropertyEntityImpl.fromJson(snapshots.data()!),
        toFirestore: (ad, _) => (ad as PropertyEntityImpl).toJson(),
      );

  @override
  int? constructionYear;

  @override
  bool isNegotiable;

  @override
  double price;

  @override
  double surface;

  PropertyEntityImpl({
    required this.surface,
    required this.price,
    required this.isNegotiable,
    required this.constructionYear,
  });

  Map<String, dynamic> toJson() {
    final json = {
      'surface': surface,
      'price': price,
      'isNegotiable': isNegotiable,
    };
    if (constructionYear != null) {
      json.addAll({'constructionYear': constructionYear!});
    }
    return json;
  }

  factory PropertyEntityImpl.fromJson(Map<String, Object?> json) {
    switch (AdCategory.values[(json['type'] as num).toInt()]) {
      case AdCategory.terrain:
        return TerrainEntityImpl.fromJson(json);
      case AdCategory.garage:
        return GarageEntityImpl.fromJson(json);
      case AdCategory.deposit:
        return DepositEntityImpl.fromJson(json);
      case AdCategory.apartament:
        return ApartmentEntityImpl.fromJson(json);
      case AdCategory.house:
        return HouseEntityImpl.fromJson(json);
      default:
        throw Exception('Unknown type: ${json['type']}');
    }
  }

  static Future<PropertyEntity?> getPropertyFromDocument(DocumentReference<Map<String, dynamic>> document) async {
    final property = await document.get();
    return PropertyEntityImpl.fromJson(property.data()!);
  }
}
