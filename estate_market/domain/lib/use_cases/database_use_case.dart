import 'package:dartz/dartz.dart';
import 'package:domain/entities/garage_entity.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:domain/repositories/image_upload_repository.dart';

import '../entities/ad_entity.dart';
import '../entities/apartment_entity.dart';
import '../entities/deposit_entity.dart';
import '../entities/document_reference_entity.dart';
import '../entities/residence_entity.dart';
import '../entities/terrain_entity.dart';
import '../errors/failure.dart';

class DatabaseUseCase {
  final DatabaseRepository _databaseRepository;
  final ImageUploadRepository _imageUploadRepository;

  DatabaseUseCase(
      {required DatabaseRepository databaseRepository, required ImageUploadRepository imageUploadRepository})
      : _databaseRepository = databaseRepository,
        _imageUploadRepository = imageUploadRepository;

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
  }) async {
    return await _databaseRepository.insertDepositEntity(
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        constructionYear: constructionYear,
        height: height,
        usableSurface: usableSurface,
        administrativeSurface: administrativeSurface,
        depositType: depositType,
        parkingSpaces: parkingSpaces);
  }

  Future<void> insertAdEntity({
    required String title,
    required AdCategory category,
    required String description,
    required DocumentReferenceEntity property,
    required ListingType listingType,
    required List<String> images,
  }) async {
    await _databaseRepository.insertAdEntity(
        title: title,
        category: category,
        description: description,
        property: property,
        listingType: listingType,
        images: images);
  }

  Future<Either<Failure, List<String>>> uploadImages(List<String> paths) async {
    final result = await _imageUploadRepository.uploadImages(paths);
    return result;
  }
}
