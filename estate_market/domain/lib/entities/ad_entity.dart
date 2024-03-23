import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/property_entity.dart';

enum AdCategory { apartament, house, terrain, garage, deposit }

enum ListingType { sale, rent }

abstract class AdEntity {
  final String title;
  final AdCategory adCategory;
  final List<String> imagesUrls;
  final String description;
  PropertyEntity? property;
  AccountEntity? account;
  final ListingType listingType;
  final DateTime dateOfAd;

  AdEntity(
      {required this.title,
      required this.adCategory,
      required this.imagesUrls,
      required this.description,
      this.property,
      this.account,
      required this.listingType,
      required this.dateOfAd});

  Future<void> setReferences();
}
