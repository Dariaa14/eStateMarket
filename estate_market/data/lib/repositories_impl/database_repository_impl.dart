import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/entities_impl/document_reference_entity_impl.dart';
import 'package:data/entities_impl/garage_entity_impl.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/document_reference_entity.dart';
import 'package:domain/entities/garage_entity.dart';
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
  Future<DocumentReferenceEntityImpl> insertGarageEntity(double surface, double price, bool isNegotiable,
      int? constructionYear, ParkingType parkingType, int capacity) async {
    CollectionReference properties = FirebaseFirestore.instance.collection('properties');
    GarageEntity garage = GarageEntityImpl(
        parkingType: parkingType, capacity: capacity, surface: surface, price: price, isNegotiable: isNegotiable);
    final ref = await properties.add((garage as GarageEntityImpl).toJson());
    return DocumentReferenceEntityImpl(ref: ref);
  }

  @override
  Future<void> insertAdEntity(String title, AdCategory category, String description, DocumentReferenceEntity property,
      ListingType listingType) async {
    CollectionReference ads = FirebaseFirestore.instance.collection('ad');
    AdEntity ad = AdEntityImpl(
        title: title,
        adCategory: category,
        description: description,
        images: [],
        propertyReference: (property as DocumentReferenceEntityImpl).ref as DocumentReference<Map<String, dynamic>>,
        listingType: listingType,
        dateOfAd: DateTime.now());
    await ad.setProperty();
    await ads.add((ad as AdEntityImpl).toJson());
  }
}
