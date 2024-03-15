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
import 'package:domain/repositories/database_repository.dart';

import '../entities_impl/ad_enitity_impl.dart';

class DatabaseRepositoryImpl extends DatabaseRepository {
  @override
  Future<List<AdEntity>> getAllAds() async {
    CollectionReferenceEntity ads = CollectionReferenceEntityImpl(collection: Collections.ad);
    return await ads.get<AdEntity>();
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
        listingType: listingType,
        dateOfAd: DateTime.now());
    await ad.setProperty();
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
}
