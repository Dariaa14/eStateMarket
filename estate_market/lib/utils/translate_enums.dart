import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/apartment_entity.dart';
import 'package:domain/entities/deposit_entity.dart';
import 'package:domain/entities/garage_entity.dart';
import 'package:domain/entities/residence_entity.dart';
import 'package:domain/entities/terrain_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:domain/entities/ad_entity.dart';

String adCategoryTranslate(AdCategory category, BuildContext context) {
  switch (category) {
    case AdCategory.apartament:
      return AppLocalizations.of(context)!.apartment;
    case AdCategory.house:
      return AppLocalizations.of(context)!.house;
    case AdCategory.terrain:
      return AppLocalizations.of(context)!.terrain;
    case AdCategory.garage:
      return AppLocalizations.of(context)!.garage;
    case AdCategory.deposit:
      return AppLocalizations.of(context)!.deposit;
    default:
      return '';
  }
}

String listingTypeTranslate(ListingType type, BuildContext context) {
  switch (type) {
    case ListingType.sale:
      return AppLocalizations.of(context)!.sale;
    case ListingType.rent:
      return AppLocalizations.of(context)!.rent;
    default:
      return '';
  }
}

String furnishingLevelTranslate(FurnishingLevel level, BuildContext context) {
  switch (level) {
    case FurnishingLevel.furnished:
      return AppLocalizations.of(context)!.furnished;
    case FurnishingLevel.semiFurnished:
      return AppLocalizations.of(context)!.semiFurnished;
    case FurnishingLevel.unfurnished:
      return AppLocalizations.of(context)!.unfurnished;
    default:
      return '';
  }
}

String partitioningTranslate(Partitioning partitioning, BuildContext context) {
  switch (partitioning) {
    case Partitioning.selfContained:
      return AppLocalizations.of(context)!.selfContained;
    case Partitioning.semiSelfContained:
      return AppLocalizations.of(context)!.semiSelfContained;
    case Partitioning.nonSelfContained:
      return AppLocalizations.of(context)!.nonSelfContained;
    case Partitioning.circular:
      return AppLocalizations.of(context)!.circular;
    default:
      return '';
  }
}

String landUseCategoriesTranslate(LandUseCategories categories, BuildContext context) {
  switch (categories) {
    case LandUseCategories.urban:
      return AppLocalizations.of(context)!.urban;
    case LandUseCategories.agriculture:
      return AppLocalizations.of(context)!.agriculture;
    case LandUseCategories.rangeland:
      return AppLocalizations.of(context)!.rangeland;
    case LandUseCategories.forestland:
      return AppLocalizations.of(context)!.forestland;
    case LandUseCategories.water:
      return AppLocalizations.of(context)!.water;
    case LandUseCategories.wetland:
      return AppLocalizations.of(context)!.wetland;
    case LandUseCategories.barren:
      return AppLocalizations.of(context)!.barren;
  }
}

String parkingTypesTranslate(ParkingType type, BuildContext context) {
  switch (type) {
    case ParkingType.interiorParking:
      return AppLocalizations.of(context)!.interiorParking;
    case ParkingType.exteriorParking:
      return AppLocalizations.of(context)!.exteriorParking;
    case ParkingType.garage:
      return AppLocalizations.of(context)!.garage;
  }
}

String depositTypesTranslate(DepositType type, BuildContext context) {
  switch (type) {
    case DepositType.deposit:
      return AppLocalizations.of(context)!.deposit;
    case DepositType.distribution:
      return AppLocalizations.of(context)!.distribution;
    case DepositType.production:
      return AppLocalizations.of(context)!.production;
  }
}

String sellerTypeTranslate(SellerType type, BuildContext context) {
  switch (type) {
    case SellerType.individual:
      return AppLocalizations.of(context)!.individual;
    case SellerType.company:
      return AppLocalizations.of(context)!.company;
    default:
      return AppLocalizations.of(context)!.unknown;
  }
}
