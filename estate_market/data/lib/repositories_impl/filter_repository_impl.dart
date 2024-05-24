import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/entities/wrappers/query_snapshot_entity.dart';
import 'package:domain/repositories/filter_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../entities_impl/ad_enitity_impl.dart';
import '../entities_impl/wrappers/collection_reference_entity_impl.dart';

class FilterRepositoryImpl implements FilterRepository {
  final _categoryController = StreamController<AdCategory?>.broadcast();

  @override
  Stream<List<AdEntity>> streamAds() {
    CollectionReferenceEntity ads = CollectionReferenceEntityImpl(collection: Collections.ad, withConverter: false);

    return Rx.combineLatest2(
            _categoryController.stream, ads.snapshots(), (category, snapshot) => Tuple2(category, snapshot))
        .asyncMap((tuple) async {
      final AdCategory? category = tuple.head;
      final QuerySnapshotEntity snapshot = tuple.tail;

      List<DocumentReferenceEntity> docRefs = snapshot.transformToDocumentReferenceList();
      List<Future<AdEntity?>> futures = docRefs.map((docRef) => AdEntityImpl.getAdFromDocument(docRef)).toList();
      List<AdEntity?> allAds = await Future.wait(futures);

      if (category == null) {
        return allAds.nonNulls.toList();
      }
      return allAds.where((ad) => ad?.adCategory == category).nonNulls.toList();
    });
  }

  @override
  void setCurrentCategory(AdCategory? category) {
    _categoryController.add(category);
  }
}
