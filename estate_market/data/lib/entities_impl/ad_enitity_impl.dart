import 'dart:typed_data';

import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/property_entity.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AdEntityImpl extends AdEntity {
  AdEntityImpl({
    required String title,
    required AdCategory adCategory,
    required List<Uint8List> images,
    required String description,
    required PropertyEntity? property,
    required ListingType listingType,
    required DateTime dateOfAd,
  }) : super(
          title: title,
          adCategory: adCategory,
          images: images,
          description: description,
          property: property,
          listingType: listingType,
          dateOfAd: dateOfAd,
        );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'adCategory': adCategory.toString(),
      'images': images.map((image) => image.toList()).toList(),
      'description': description,
      'property': null,
      'listingType': listingType.toString(),
      'dateOfAd': Timestamp.fromDate(dateOfAd),
    };
  }

  factory AdEntityImpl.fromJson(Map<String, Object?> json) {
    return AdEntityImpl(
      title: json['title'] as String,
      adCategory: AdCategory.values[json['adCategory'] as int],
      images: [], // (json['images'] as List).map((image) => Uint8List.fromList(image.cast<int>())).toList(),
      description: json['description'] as String,
      property: null,
      listingType: ListingType.values[json['listingType'] as int],
      dateOfAd: (json['dateOfAd'] as Timestamp).toDate(),
    );
  }
}
