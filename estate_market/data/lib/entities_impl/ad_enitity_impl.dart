import 'dart:typed_data';

import 'package:data/entities_impl/property_entity_impl.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/property_entity.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AdEntityImpl extends AdEntity {
  DocumentReference<Map<String, dynamic>>? _propertyReference;

  AdEntityImpl({
    required String title,
    required AdCategory adCategory,
    required List<Uint8List> images,
    required String description,
    required DocumentReference<Map<String, dynamic>>? propertyReference,
    required ListingType listingType,
    required DateTime dateOfAd,
  })  : _propertyReference = propertyReference,
        super(
          title: title,
          adCategory: adCategory,
          images: images,
          description: description,
          listingType: listingType,
          dateOfAd: dateOfAd,
        );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'adCategory': adCategory.index,
      'images': images.map((image) => image.toList()).toList(),
      'description': description,
      'property': (property as PropertyEntityImpl).toJson(),
      'listingType': listingType.index,
      'dateOfAd': Timestamp.fromDate(dateOfAd),
    };
  }

  factory AdEntityImpl.fromJson(Map<String, Object?> json) {
    return AdEntityImpl(
      title: json['title'] as String,
      adCategory: AdCategory.values[json['adCategory'] as int],
      images: [], // (json['images'] as List).map((image) => Uint8List.fromList(image.cast<int>())).toList(),
      description: json['description'] as String,
      listingType: ListingType.values[json['listingType'] as int],
      dateOfAd: (json['dateOfAd'] as Timestamp).toDate(),
      propertyReference:
          (json.containsKey('property')) ? json['property'] as DocumentReference<Map<String, dynamic>> : null,
    );
  }

  @override
  Future<void> setProperty() async {
    if (_propertyReference == null) return;
    PropertyEntity? property = await PropertyEntityImpl.getPropertyFromDocument(_propertyReference!);
    this.property = property;
  }
}
