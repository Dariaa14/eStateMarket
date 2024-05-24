import 'package:data/entities_impl/account_entity_impl.dart';
import 'package:data/entities_impl/apartment_entity_impl.dart';
import 'package:data/entities_impl/deposit_entity_impl.dart';
import 'package:data/entities_impl/garage_entity_impl.dart';
import 'package:data/entities_impl/house_entity_impl.dart';
import 'package:data/entities_impl/terrain_entity_impl.dart';
import 'package:data/entities_impl/wrappers/collection_reference_entity_impl.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/apartment_entity.dart';
import 'package:domain/entities/deposit_entity.dart';
import 'package:domain/entities/garage_entity.dart';
import 'package:domain/entities/house_entity.dart';
import 'package:domain/entities/residence_entity.dart';
import 'package:domain/entities/terrain_entity.dart';
import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:domain/entities/wrappers/query_snapshot_entity.dart';
import 'package:domain/repositories/database_repository.dart';

import '../entities_impl/ad_enitity_impl.dart';
import '../entities_impl/wrappers/document_reference_entity_impl.dart';
import '../entities_impl/wrappers/landmark_entity_impl.dart';
import '../utils/convert.dart';

class DatabaseRepositoryImpl extends DatabaseRepository {
  @override
  Stream<List<AdEntity?>> streamAds() {
    CollectionReferenceEntity ads = CollectionReferenceEntityImpl(collection: Collections.ad, withConverter: false);
    return ads.snapshots().asyncMap((QuerySnapshotEntity snapshot) async {
      List<DocumentReferenceEntity> docRefs = snapshot.transformToDocumentReferenceList();
      List<Future<AdEntity?>> futures = docRefs.map((docRef) => AdEntityImpl.getAdFromDocument(docRef)).toList();
      return await Future.wait(futures);
    });
  }

  @override
  Future<DocumentReferenceEntity> insertGarageEntity(
      {required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required ParkingType parkingType,
      required int capacity}) async {
    CollectionReferenceEntity properties = CollectionReferenceEntityImpl(collection: Collections.properties);
    GarageEntity garage = GarageEntityImpl(
        parkingType: parkingType,
        capacity: capacity,
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        constructionYear: constructionYear);
    return await properties.add((garage as GarageEntityImpl).toJson());
  }

  @override
  Future<void> insertAdEntity({
    required String title,
    required AdCategory category,
    required String description,
    required DocumentReferenceEntity property,
    required DocumentReferenceEntity account,
    required DocumentReferenceEntity landmark,
    required ListingType listingType,
    required List<String> images,
  }) async {
    CollectionReferenceEntity ads = CollectionReferenceEntityImpl(collection: Collections.ad, withConverter: false);
    AdEntity ad = AdEntityImpl(
        title: title,
        adCategory: category,
        description: description,
        imagesUrls: images,
        propertyReference: property,
        accountReference: account,
        landmarkReference: landmark,
        listingType: listingType,
        dateOfAd: DateTime.now());
    await ad.setReferences();
    await ads.add((ad as AdEntityImpl).toJson());
  }

  @override
  Future<DocumentReferenceEntity> insertTerrainEntity(
      {required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required bool isInBuildUpArea,
      required LandUseCategories landUseCategory}) async {
    CollectionReferenceEntity properties = CollectionReferenceEntityImpl(collection: Collections.properties);
    TerrainEntity terrain = TerrainEntityImpl(
        isInBuildUpArea: isInBuildUpArea,
        landUseCategory: landUseCategory,
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        constructionYear: constructionYear);
    return await properties.add((terrain as TerrainEntityImpl).toJson());
  }

  @override
  Future<DocumentReferenceEntity> insertApartmentEntity(
      {required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required Partitioning partitioning,
      required int floor,
      required int numberOfRooms,
      required int numberOfBathrooms,
      required FurnishingLevel furnishingLevel}) async {
    CollectionReferenceEntity properties = CollectionReferenceEntityImpl(collection: Collections.properties);
    ApartmentEntity apartment = ApartmentEntityImpl(
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        partitioning: partitioning,
        floor: floor,
        numberOfRooms: numberOfRooms,
        numberOfBathrooms: numberOfBathrooms,
        furnishingLevel: furnishingLevel,
        constructionYear: constructionYear);
    return await properties.add((apartment as ApartmentEntityImpl).toJson());
  }

  @override
  Future<DocumentReferenceEntity> insertHouseEntity(
      {required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required double insideSurface,
      required double outsideSurface,
      required int numberOfFloors,
      required int numberOfRooms,
      required int numberOfBathrooms,
      required FurnishingLevel furnishingLevel}) async {
    CollectionReferenceEntity properties = CollectionReferenceEntityImpl(collection: Collections.properties);
    HouseEntity house = HouseEntityImpl(
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        numberOfRooms: numberOfRooms,
        numberOfBathrooms: numberOfBathrooms,
        furnishingLevel: furnishingLevel,
        insideSurface: insideSurface,
        outsideSurface: outsideSurface,
        numberOfFloors: numberOfFloors,
        constructionYear: constructionYear);
    return await properties.add((house as HouseEntityImpl).toJson());
  }

  @override
  Future<DocumentReferenceEntity> insertDepositEntity(
      {required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required double height,
      required double usableSurface,
      required double administrativeSurface,
      required DepositType depositType,
      required int parkingSpaces}) async {
    CollectionReferenceEntity properties = CollectionReferenceEntityImpl(collection: Collections.properties);
    DepositEntity deposit = DepositEntityImpl(
      surface: surface,
      price: price,
      isNegotiable: isNegotiable,
      constructionYear: constructionYear,
      height: height,
      usableSurface: usableSurface,
      administrativeSurface: administrativeSurface,
      depositType: depositType,
      parkingSpaces: parkingSpaces,
    );
    return await properties.add((deposit as DepositEntityImpl).toJson());
  }

  @override
  Future<void> insertAccountEntity(
      {required String email,
      required String password,
      required String phoneNumber,
      required SellerType sellerType}) async {
    CollectionReferenceEntity accounts =
        CollectionReferenceEntityImpl(collection: Collections.accounts, withConverter: false);
    AccountEntity account = AccountEntityImpl(
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      sellerType: sellerType,
    );
    await accounts.add((account as AccountEntityImpl).toJson());
  }

  @override
  Future<void> insertFavoriteAd({required AccountEntity account, required AdEntity ad}) async {
    CollectionReferenceEntity accounts =
        CollectionReferenceEntityImpl(collection: Collections.accounts, withConverter: false);
    CollectionReferenceEntity ads = CollectionReferenceEntityImpl(collection: Collections.ad, withConverter: false);
    CollectionReferenceEntity favorites =
        CollectionReferenceEntityImpl(collection: Collections.favorites, withConverter: false);

    final accountDocument = await accounts.where('email', WhereOperations.isEqualTo, account.email).getDocuments();
    final adDocument =
        await ads.where('dateOfAd', WhereOperations.isEqualTo, convertDateTimeToTimestamp(ad.dateOfAd)).getDocuments();

    if (accountDocument.isEmpty || adDocument.isEmpty) {
      throw Exception('Account or Ad not found');
    }

    favorites.add({
      'account': (accountDocument.first as DocumentReferenceEntityImpl).ref,
      'ad': (adDocument.first as DocumentReferenceEntityImpl).ref,
    });
  }

  @override
  Future<void> removeFavoriteAd({required AccountEntity account, required AdEntity ad}) async {
    CollectionReferenceEntity accounts =
        CollectionReferenceEntityImpl(collection: Collections.accounts, withConverter: false);
    CollectionReferenceEntity ads = CollectionReferenceEntityImpl(collection: Collections.ad, withConverter: false);
    CollectionReferenceEntity favorites = CollectionReferenceEntityImpl(collection: Collections.favorites);

    final accountDocument = await accounts.where('email', WhereOperations.isEqualTo, account.email).getDocuments();
    final adDocument =
        await ads.where('dateOfAd', WhereOperations.isEqualTo, convertDateTimeToTimestamp(ad.dateOfAd)).getDocuments();

    if (accountDocument.isEmpty || adDocument.isEmpty) {
      throw Exception('Account or Ad not found');
    }
    final favoriteDocument = await favorites
        .where('account', WhereOperations.isEqualTo, (accountDocument.first as DocumentReferenceEntityImpl).ref)
        .where('ad', WhereOperations.isEqualTo, (adDocument.first as DocumentReferenceEntityImpl).ref)
        .getDocuments();
    if (favoriteDocument.isEmpty) {
      throw Exception('Favorite not found');
    }
    await favoriteDocument.first.delete();
  }

  @override
  Future<DocumentReferenceEntity> insertLandmarkEntity({required LandmarkEntity landmark}) async {
    CollectionReferenceEntity landmarks =
        CollectionReferenceEntityImpl(collection: Collections.landmarks, withConverter: false);
    return await landmarks.add((landmark as LandmarkEntityImpl).toJson());
  }

  @override
  Future<void> updateLandmarkEntity(
      {required LandmarkEntity previousLandmark, required LandmarkEntity landmark}) async {
    CollectionReferenceEntity landmarks =
        CollectionReferenceEntityImpl(collection: Collections.landmarks, withConverter: false);
    final landmarkDocument = await landmarks
        .where('latitude', WhereOperations.isEqualTo, previousLandmark.getCoordinates().getLatitude())
        .where('longitude', WhereOperations.isEqualTo, previousLandmark.getCoordinates().getLongitude())
        .getDocuments();
    await landmarkDocument.first.set((landmark as LandmarkEntityImpl).toJson());
  }

  @override
  Future<void> updateAdEntity(
      {required AdEntity previousAd,
      required String title,
      required AdCategory category,
      required String description,
      required ListingType listingType,
      required List<String> images}) async {
    CollectionReferenceEntity ads = CollectionReferenceEntityImpl(collection: Collections.ad, withConverter: false);
    final adDocument = await ads
        .where('dateOfAd', WhereOperations.isEqualTo, convertDateTimeToTimestamp(previousAd.dateOfAd))
        .getDocuments();
    AdEntity ad = AdEntityImpl(
        title: title,
        adCategory: category,
        description: description,
        imagesUrls: images,
        propertyReference: null,
        accountReference: null,
        landmarkReference: null,
        listingType: listingType,
        dateOfAd: previousAd.dateOfAd);
    await adDocument.first.set((ad as AdEntityImpl).toJson());
  }

  @override
  Future<void> updateGarageEntity(
      {required DocumentReferenceEntity previousProperty,
      required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required ParkingType parkingType,
      required int capacity}) async {
    GarageEntity garage = GarageEntityImpl(
        parkingType: parkingType,
        capacity: capacity,
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        constructionYear: constructionYear);
    await previousProperty.set((garage as GarageEntityImpl).toJson());
  }

  @override
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
      required FurnishingLevel furnishingLevel}) async {
    ApartmentEntity apartment = ApartmentEntityImpl(
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        partitioning: partitioning,
        floor: floor,
        numberOfRooms: numberOfRooms,
        numberOfBathrooms: numberOfBathrooms,
        furnishingLevel: furnishingLevel,
        constructionYear: constructionYear);
    await previousProperty.set((apartment as ApartmentEntityImpl).toJson());
  }

  @override
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
      required FurnishingLevel furnishingLevel}) async {
    HouseEntity house = HouseEntityImpl(
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        numberOfRooms: numberOfRooms,
        numberOfBathrooms: numberOfBathrooms,
        furnishingLevel: furnishingLevel,
        insideSurface: insideSurface,
        outsideSurface: outsideSurface,
        numberOfFloors: numberOfFloors,
        constructionYear: constructionYear);
    await previousProperty.set((house as HouseEntityImpl).toJson());
  }

  @override
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
      required int parkingSpaces}) async {
    DepositEntity deposit = DepositEntityImpl(
      surface: surface,
      price: price,
      isNegotiable: isNegotiable,
      constructionYear: constructionYear,
      height: height,
      usableSurface: usableSurface,
      administrativeSurface: administrativeSurface,
      depositType: depositType,
      parkingSpaces: parkingSpaces,
    );
    await previousProperty.set((deposit as DepositEntityImpl).toJson());
  }

  @override
  Future<void> updateTerrainEntity(
      {required DocumentReferenceEntity previousProperty,
      required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required bool isInBuildUpArea,
      required LandUseCategories landUseCategory}) async {
    TerrainEntity terrain = TerrainEntityImpl(
        isInBuildUpArea: isInBuildUpArea,
        landUseCategory: landUseCategory,
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        constructionYear: constructionYear);
    await previousProperty.set((terrain as TerrainEntityImpl).toJson());
  }
}
