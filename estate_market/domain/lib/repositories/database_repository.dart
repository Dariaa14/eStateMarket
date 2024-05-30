import 'package:domain/entities/apartment_entity.dart';
import 'package:domain/entities/deposit_entity.dart';
import 'package:domain/entities/residence_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';

import '../entities/account_entity.dart';
import '../entities/ad_entity.dart';
import '../entities/garage_entity.dart';
import '../entities/terrain_entity.dart';
import '../entities/wrappers/document_reference_entity.dart';

abstract class DatabaseRepository {
  Future<DocumentReferenceEntity> insertGarageEntity({
    required double surface,
    required double price,
    required bool isNegotiable,
    required int? constructionYear,
    required ParkingType parkingType,
    required int capacity,
  });

  Future<void> updateGarageEntity(
      {required DocumentReferenceEntity previousProperty,
      required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required ParkingType parkingType,
      required int capacity});

  Future<DocumentReferenceEntity> insertApartmentEntity({
    required double surface,
    required double price,
    required bool isNegotiable,
    required int? constructionYear,
    required Partitioning partitioning,
    required int floor,
    required int numberOfRooms,
    required int numberOfBathrooms,
    required FurnishingLevel furnishingLevel,
  });

  Future<void> updateApartmentEntity(
      {required DocumentReferenceEntity previousProperty,
      required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required Partitioning partitioning,
      required int floor,
      required int numberOfRooms,
      required int numberOfBathrooms,
      required FurnishingLevel furnishingLevel});

  Future<DocumentReferenceEntity> insertHouseEntity({
    required double surface,
    required double price,
    required bool isNegotiable,
    required int? constructionYear,
    required double insideSurface,
    required double outsideSurface,
    required int numberOfFloors,
    required int numberOfRooms,
    required int numberOfBathrooms,
    required FurnishingLevel furnishingLevel,
  });

  Future<void> updateHouseEntity(
      {required DocumentReferenceEntity previousProperty,
      required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required double insideSurface,
      required double outsideSurface,
      required int numberOfFloors,
      required int numberOfRooms,
      required int numberOfBathrooms,
      required FurnishingLevel furnishingLevel});

  Future<DocumentReferenceEntity> insertTerrainEntity({
    required double surface,
    required double price,
    required bool isNegotiable,
    required int? constructionYear,
    required bool isInBuildUpArea,
    required LandUseCategories landUseCategory,
  });

  Future<void> updateTerrainEntity(
      {required DocumentReferenceEntity previousProperty,
      required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required bool isInBuildUpArea,
      required LandUseCategories landUseCategory});

  Future<DocumentReferenceEntity> insertDepositEntity({
    required double surface,
    required double price,
    required bool isNegotiable,
    required int? constructionYear,
    required double height,
    required double usableSurface,
    required double administrativeSurface,
    required DepositType depositType,
    required int parkingSpaces,
  });

  Future<void> updateDepositEntity(
      {required DocumentReferenceEntity previousProperty,
      required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required double height,
      required double usableSurface,
      required double administrativeSurface,
      required DepositType depositType,
      required int parkingSpaces});

  Future<void> insertAdEntity({
    required String title,
    required AdCategory category,
    required String description,
    required DocumentReferenceEntity property,
    required DocumentReferenceEntity account,
    required DocumentReferenceEntity landmark,
    required ListingType listingType,
    required List<String> images,
  });

  Future<void> insertAccountEntity({
    required String email,
    required String password,
    required String phoneNumber,
    required SellerType sellerType,
  });

  Future<void> updateAdEntity(
      {required AdEntity previousAd,
      required String title,
      required AdCategory category,
      required String description,
      required ListingType listingType,
      required List<String> images});

  Future<DocumentReferenceEntity> insertLandmarkEntity({required LandmarkEntity landmark});
  Future<void> updateLandmarkEntity({required LandmarkEntity previousLandmark, required LandmarkEntity landmark});

  Future<void> insertFavoriteAd({required AccountEntity account, required AdEntity ad});

  Future<void> removeFavoriteAd({required AccountEntity account, required AdEntity ad});

  Future<void> removeAd({required AdEntity ad});

  Future<void> insertMessage({required AccountEntity sender, required AccountEntity receiver, required String message});
}
