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
  final _listingTypeController = StreamController<ListingType?>.broadcast();
  final _priceRangeController = StreamController<Tuple2<double?, double?>>.broadcast();
  final _surfaceRangeController = StreamController<Tuple2<double?, double?>>.broadcast();

  @override
  Stream<List<AdEntity>> streamAds() {
    CollectionReferenceEntity ads = CollectionReferenceEntityImpl(collection: Collections.ad, withConverter: false);

    return Rx.combineLatest5(
        _categoryController.stream,
        _listingTypeController.stream,
        _priceRangeController.stream,
        _surfaceRangeController.stream,
        ads.snapshots(),
        (category, listingType, priceRange, surfaceRange, snapshot) =>
            Tuple5(category, listingType, priceRange, surfaceRange, snapshot)).asyncMap((tuple) async {
      final AdCategory? category = tuple.value1;
      final ListingType? listingType = tuple.value2;
      final Tuple2<double?, double?> priceRange = tuple.value3;
      final Tuple2<double?, double?> surfaceRange = tuple.value4;
      final QuerySnapshotEntity snapshot = tuple.value5;

      List<DocumentReferenceEntity> docRefs = snapshot.transformToDocumentReferenceList();
      List<Future<AdEntity?>> futures = docRefs.map((docRef) => AdEntityImpl.getAdFromDocument(docRef)).toList();
      List<AdEntity?> allAds = await Future.wait(futures);

      final sortedByCategory = allAds.where((ad) => category == null || ad?.adCategory == category).nonNulls.toList();
      final sortedByListingType =
          sortedByCategory.where((ad) => listingType == null || ad.listingType == listingType).toList();
      final sortedByPrice = sortedByListingType
          .where((ad) => priceRange.head == null || priceRange.head! <= ad.property!.price)
          .where((ad) => priceRange.tail == null || priceRange.tail! >= ad.property!.price)
          .toList();
      final sortedBySurface = sortedByPrice
          .where((ad) => surfaceRange.head == null || surfaceRange.head! <= ad.property!.surface)
          .where((ad) => surfaceRange.tail == null || surfaceRange.tail! >= ad.property!.surface)
          .toList();
      return sortedBySurface;
    });
  }

  @override
  void setCurrentCategory(AdCategory? category) {
    _categoryController.add(category);
  }

  @override
  void setCurrentListingType(ListingType? listingType) {
    _listingTypeController.add(listingType);
  }

  @override
  void setPriceRange(Tuple2<double?, double?> priceRange) {
    _priceRangeController.add(priceRange);
  }

  @override
  void setSurfaceRange(Tuple2<double?, double?> surfaceRange) {
    _surfaceRangeController.add(surfaceRange);
  }
}
