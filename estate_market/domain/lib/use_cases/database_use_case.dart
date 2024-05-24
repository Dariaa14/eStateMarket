import 'package:dartz/dartz.dart';
import 'package:domain/entities/garage_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:domain/repositories/account_repository.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:domain/repositories/image_upload_repository.dart';

import '../entities/account_entity.dart';
import '../entities/ad_entity.dart';
import '../entities/apartment_entity.dart';
import '../entities/deposit_entity.dart';
import '../entities/residence_entity.dart';
import '../entities/terrain_entity.dart';
import '../entities/wrappers/document_reference_entity.dart';
import '../errors/failure.dart';

class DatabaseUseCase {
  final DatabaseRepository _databaseRepository;
  final ImageUploadRepository _imageUploadRepository;
  final AccountRepository _accountRepository;

  DatabaseUseCase(
      {required DatabaseRepository databaseRepository,
      required ImageUploadRepository imageUploadRepository,
      required AccountRepository accountRepository})
      : _databaseRepository = databaseRepository,
        _imageUploadRepository = imageUploadRepository,
        _accountRepository = accountRepository;

  Stream<List<AdEntity>> getAllAds() {
    return _databaseRepository.streamAds().map((list) => list.whereType<AdEntity>().toList());
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
    required DocumentReferenceEntity landmark,
    required ListingType listingType,
    required List<String> images,
  }) async {
    final currentUserRef = _accountRepository.currentAccountDocument;
    if (currentUserRef == null) throw Exception('User not found');

    await _databaseRepository.insertAdEntity(
        title: title,
        category: category,
        description: description,
        property: property,
        account: currentUserRef,
        listingType: listingType,
        landmark: landmark,
        images: images);
  }

  Future<void> insertAccountEntity({
    required String email,
    required String password,
    required String phoneNumber,
    required SellerType sellerType,
  }) async {
    await _databaseRepository.insertAccountEntity(
        email: email, password: password, phoneNumber: phoneNumber, sellerType: sellerType);
  }

  Future<DocumentReferenceEntity> insertLandmarkEntity({required LandmarkEntity landmark}) async {
    return await _databaseRepository.insertLandmarkEntity(landmark: landmark);
  }

  Future<Either<Failure, List<String>>> uploadImages(List<String> paths) async {
    final result = await _imageUploadRepository.uploadImages(paths);
    return result;
  }

  Future<void> updateLandmark({required LandmarkEntity previousLandmark, required LandmarkEntity landmark}) async {
    await _databaseRepository.updateLandmarkEntity(landmark: landmark, previousLandmark: previousLandmark);
  }

  Future<void> updateAd(
      {required AdEntity previousAd,
      required String title,
      required AdCategory category,
      required String description,
      required ListingType listingType,
      required List<String> images}) async {
    await _databaseRepository.updateAdEntity(
        title: title,
        category: category,
        description: description,
        listingType: listingType,
        images: images,
        previousAd: previousAd);
  }

  Future<void> updateGarageEntity({
    required DocumentReferenceEntity previousProperty,
    required double surface,
    required double price,
    required bool isNegotiable,
    required int? constructionYear,
    required ParkingType parkingType,
    required int capacity,
  }) async {
    await _databaseRepository.updateGarageEntity(
        previousProperty: previousProperty,
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        constructionYear: constructionYear,
        parkingType: parkingType,
        capacity: capacity);
  }

  Future<void> updateApartmentEntity({
    required DocumentReferenceEntity previousProperty,
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
    await _databaseRepository.updateApartmentEntity(
      previousProperty: previousProperty,
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

  Future<void> updateHouseEntity({
    required DocumentReferenceEntity previousProperty,
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
    await _databaseRepository.updateHouseEntity(
      previousProperty: previousProperty,
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

  Future<void> updateDepositEntity({
    required DocumentReferenceEntity previousProperty,
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
    await _databaseRepository.updateDepositEntity(
        previousProperty: previousProperty,
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

  Future<void> updateTerrainEntity({
    required DocumentReferenceEntity previousProperty,
    required double surface,
    required double price,
    required bool isNegotiable,
    required int? constructionYear,
    required bool isInBuildUpArea,
    required LandUseCategories landUseCategory,
  }) async {
    await _databaseRepository.updateTerrainEntity(
        previousProperty: previousProperty,
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        constructionYear: constructionYear,
        isInBuildUpArea: isInBuildUpArea,
        landUseCategory: landUseCategory);
  }
}
