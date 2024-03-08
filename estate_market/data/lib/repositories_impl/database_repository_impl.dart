import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/entities_impl/apartment_entity_impl.dart';
import 'package:data/entities_impl/deposit_entity_impl.dart';
import 'package:data/entities_impl/document_reference_entity_impl.dart';
import 'package:data/entities_impl/garage_entity_impl.dart';
import 'package:data/entities_impl/house_entity_impl.dart';
import 'package:data/entities_impl/terrain_entity_impl.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/apartment_entity.dart';
import 'package:domain/entities/deposit_entity.dart';
import 'package:domain/entities/document_reference_entity.dart';
import 'package:domain/entities/garage_entity.dart';
import 'package:domain/entities/house_entity.dart';
import 'package:domain/entities/residence_entity.dart';
import 'package:domain/entities/terrain_entity.dart';
import 'package:domain/repositories/database_repository.dart';

import '../entities_impl/ad_enitity_impl.dart';

class DatabaseRepositoryImpl extends DatabaseRepository {
  final adRef = FirebaseFirestore.instance.collection('ad').withConverter<AdEntity>(
        fromFirestore: (snapshots, _) => AdEntityImpl.fromJson(snapshots.data()!),
        toFirestore: (ad, _) => (ad as AdEntityImpl).toJson(),
      );

  @override
  Future<List<AdEntity>> getAllAds() async {
    List<AdEntity> allAds = [];
    final items = await adRef.get();
    for (int index = 0; index < items.size; index++) {
      AdEntity ad = items.docs[index].data();
      await (ad as AdEntityImpl).setProperty();
      allAds.add(ad);
    }
    return allAds;
  }

  @override
  Future<DocumentReferenceEntity> insertGarageEntity(
      {required double surface,
      required double price,
      required bool isNegotiable,
      required int? constructionYear,
      required ParkingType parkingType,
      required int capacity}) async {
    CollectionReference properties = FirebaseFirestore.instance.collection('properties');
    GarageEntity garage = GarageEntityImpl(
        parkingType: parkingType,
        capacity: capacity,
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        constructionYear: constructionYear);
    final ref = await properties.add((garage as GarageEntityImpl).toJson());
    return DocumentReferenceEntityImpl(ref: ref);
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
    CollectionReference ads = FirebaseFirestore.instance.collection('ad');
    AdEntity ad = AdEntityImpl(
        title: title,
        adCategory: category,
        description: description,
        imagesUrls: images,
        propertyReference: (property as DocumentReferenceEntityImpl).ref as DocumentReference<Map<String, dynamic>>,
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
    CollectionReference properties = FirebaseFirestore.instance.collection('properties');
    TerrainEntity terrain = TerrainEntityImpl(
        isInBuildUpArea: isInBuildUpArea,
        landUseCategory: landUseCategory,
        surface: surface,
        price: price,
        isNegotiable: isNegotiable,
        constructionYear: constructionYear);
    final ref = await properties.add((terrain as TerrainEntityImpl).toJson());
    return DocumentReferenceEntityImpl(ref: ref);
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
    CollectionReference properties = FirebaseFirestore.instance.collection('properties');
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
    final ref = await properties.add((apartment as ApartmentEntityImpl).toJson());
    return DocumentReferenceEntityImpl(ref: ref);
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
    CollectionReference properties = FirebaseFirestore.instance.collection('properties');
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
    final ref = await properties.add((house as HouseEntityImpl).toJson());
    return DocumentReferenceEntityImpl(ref: ref);
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
    CollectionReference properties = FirebaseFirestore.instance.collection('properties');
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
    final ref = await properties.add((deposit as DepositEntityImpl).toJson());
    return DocumentReferenceEntityImpl(ref: ref);
  }
}
