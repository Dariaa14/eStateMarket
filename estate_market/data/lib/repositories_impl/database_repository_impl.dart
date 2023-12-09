import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/ad_entity.dart';
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
}
