import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/property_entity.dart';

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
    return PropertyEntityImpl(
      surface: (json['surface'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      isNegotiable: json['isNegotiable'] as bool,
      constructionYear: (json.containsKey('constructionYear')) ? json['constructionYear'] as int : null,
    );
  }

  static Future<PropertyEntity?> getPropertyFromDocument(DocumentReference<Map<String, dynamic>> document) async {
    final property = await document.get();
    return PropertyEntityImpl.fromJson(property.data()!);
  }
}
