import 'package:domain/entities/property_entity.dart';

enum AdCategory { apartament, house, terrain, garage, deposit }

enum ListingType { sale, rent }

abstract class AdEntity {
  final String title;
  final AdCategory adCategory;
  final List<String> imagesUrls;
  final String description;
  PropertyEntity? property;
  final ListingType listingType;
  final DateTime dateOfAd;

  AdEntity(
      {required this.title,
      required this.adCategory,
      required this.imagesUrls,
      required this.description,
      this.property,
      required this.listingType,
      required this.dateOfAd});

  Future<void> setProperty();
}
