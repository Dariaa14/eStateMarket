import 'dart:typed_data';

import 'package:domain/entities/property_entity.dart';

enum AdCategory { apartament, house, terrain, garage, deposit }

enum ListingType { sale, rent }

abstract class AdEntity {
  final String title;
  final AdCategory adCategory;
  final List<Uint8List> images;
  final String description;
  final PropertyEntity property;
  final ListingType listingType;
  final DateTime dateOfAd;

  AdEntity(
      {required this.title,
      required this.adCategory,
      required this.images,
      required this.description,
      required this.property,
      required this.listingType,
      required this.dateOfAd});
}
