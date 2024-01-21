import 'dart:typed_data';

import 'package:data/entities_impl/property_entity_impl.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/property_entity.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AdEntityImpl implements AdEntity {
  DocumentReference<Map<String, dynamic>>? _propertyReference;

  @override
  PropertyEntity? property;

  @override
  AdCategory adCategory;

  @override
  DateTime dateOfAd;

  @override
  String description;

  @override
  List<Uint8List> images;

  @override
  ListingType listingType;

  @override
  String title;

  AdEntityImpl(
      {required this.title,
      required this.adCategory,
      required this.images,
      required this.description,
      this.property,
      required this.listingType,
      required this.dateOfAd,
      required DocumentReference<Map<String, dynamic>>? propertyReference})
      : _propertyReference = propertyReference;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'adCategory': adCategory.index,
      'images': images.map((image) => image.toList()).toList(),
      'description': description,
      'property': _propertyReference,
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
