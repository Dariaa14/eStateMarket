import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/property_entity.dart';

class PropertyEntityImpl extends PropertyEntity {
  static final propertyRef = FirebaseFirestore.instance.collection('properties').withConverter<PropertyEntity>(
        fromFirestore: (snapshots, _) => PropertyEntityImpl.fromJson(snapshots.data()!),
        toFirestore: (ad, _) => (ad as PropertyEntityImpl).toJson(),
      );

  PropertyEntityImpl({
    required double surface,
    required double price,
    required bool isNegociable,
    int? constructionYear,
  }) : super(
          surface: surface,
          price: price,
          isNegotiable: isNegociable,
          constructionYear: constructionYear,
        );

  Map<String, dynamic> toJson() {
    return {
      'surface': surface,
      'price': price,
      'isNegociable': isNegotiable,
      'constructionYear': constructionYear,
    };
  }

  factory PropertyEntityImpl.fromJson(Map<String, Object?> json) {
    return PropertyEntityImpl(
      surface: json['surface'] as double,
      price: json['price'] as double,
      isNegociable: json['isNegociable'] as bool,
      constructionYear: json['constructionYear'] as int?,
    );
  }

  static Future<PropertyEntity?> getPropertyFromDocument(DocumentReference<Map<String, dynamic>> document) async {
    final property = await document.get();
    return PropertyEntityImpl.fromJson(property.data()!);
  }
}
