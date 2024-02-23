import 'package:domain/entities/garage_entity.dart';
import 'package:domain/repositories/database_repository.dart';

import '../entities/ad_entity.dart';
import '../entities/apartment_entity.dart';
import '../entities/document_reference_entity.dart';
import '../entities/residence_entity.dart';
import '../entities/terrain_entity.dart';

class DatabaseUseCase {
  final DatabaseRepository _databaseRepository;

  DatabaseUseCase({required DatabaseRepository databaseRepository}) : _databaseRepository = databaseRepository;

  Future<List<AdEntity>> getAllAds() async {
    final resp = await _databaseRepository.getAllAds();
    return resp;
  }

  Future<DocumentReferenceEntity> insertGarageEntity({
    required double surface,
    required double price,
    required bool isNegotiable,
    required int? constructionYear,
    required ParkingType parkingType,
    required int capacity,
  }) async {
    return await _databaseRepository.insertGarageEntity(
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        constructionYear: constructionYear,
        parkingType: parkingType,
        capacity: capacity);
  }

  Future<DocumentReferenceEntity> insertTerrainEntity({
    required double surface,
    required double price,
    required bool isNegotiable,
    required int? constructionYear,
    required bool isInBuildUpArea,
    required LandUseCategories landUseCategory,
  }) async {
    return await _databaseRepository.insertTerrainEntity(
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        constructionYear: constructionYear,
        isInBuildUpArea: isInBuildUpArea,
        landUseCategory: landUseCategory);
  }

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
  }) async {
    return await _databaseRepository.insertApartmentEntity(
      surface: surface,
      price: price,
      isNegotiable: isNegotiable,
      constructionYear: constructionYear,
      partitioning: partitioning,
      floor: floor,
      numberOfRooms: numberOfRooms,
      numberOfBathrooms: numberOfBathrooms,
      furnishingLevel: furnishingLevel,
    );
  }

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
  }) async {
    return await _databaseRepository.insertHouseEntity(
      surface: surface,
      price: price,
      isNegotiable: isNegotiable,
      constructionYear: constructionYear,
      insideSurface: insideSurface,
      outsideSurface: outsideSurface,
      numberOfFloors: numberOfFloors,
      numberOfRooms: numberOfRooms,
      numberOfBathrooms: numberOfBathrooms,
      furnishingLevel: furnishingLevel,
    );
  }

  Future<void> insertAdEntity({
    required String title,
    required AdCategory category,
    required String description,
    required DocumentReferenceEntity property,
    required ListingType listingType,
  }) async {
    await _databaseRepository.insertAdEntity(
        title: title, category: category, description: description, property: property, listingType: listingType);
  }
}
