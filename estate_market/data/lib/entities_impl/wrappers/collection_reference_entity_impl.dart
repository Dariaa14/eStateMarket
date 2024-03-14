import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/entities/wrappers/query_entity.dart';

import '../account_entity_impl.dart';
import '../ad_enitity_impl.dart';
import 'document_reference_entity_impl.dart';
import 'query_entity_impl.dart';

class CollectionReferenceEntityImpl extends CollectionReferenceEntity {
  @override
  Future<DocumentReferenceEntity> add(Collections collection, Map<String, dynamic> map) async {
    final currentCollection = _getCollection(collection);
    DocumentReference ref = await currentCollection.add(map);
    return DocumentReferenceEntityImpl(ref: ref);
  }

  @override
  Future<List<T>> get<T>(Collections collection) async {
    final currentCollection = _getCollection(collection);
    final items = await currentCollection.get();
    List<T> allItems = [];
    for (int index = 0; index < items.size; index++) {
      T item = items.docs[index].data() as T;
      if (T is AdEntity) {
        await (item as AdEntityImpl).setProperty();
      }
      allItems.add(item);
    }
    return allItems;
  }

  @override
  QueryEntity where<T>(Collections collection, String field, WhereOperations operation, dynamic value) {
    final currentCollection = _getCollection(collection);
    switch (operation) {
      case WhereOperations.isEqualTo:
        return QueryEntityImpl(ref: currentCollection.where(field, isEqualTo: value));
      case WhereOperations.isNotEqualTo:
        return QueryEntityImpl(ref: currentCollection.where(field, isNotEqualTo: value));
      case WhereOperations.isLessThan:
        return QueryEntityImpl(ref: currentCollection.where(field, isLessThan: value));
      case WhereOperations.isLessThanOrEqualTo:
        return QueryEntityImpl(ref: currentCollection.where(field, isLessThanOrEqualTo: value));
      case WhereOperations.isGreaterThan:
        return QueryEntityImpl(ref: currentCollection.where(field, isGreaterThan: value));
      case WhereOperations.isGreaterThanOrEqualTo:
        return QueryEntityImpl(ref: currentCollection.where(field, isGreaterThanOrEqualTo: value));
      case WhereOperations.arrayContains:
        return QueryEntityImpl(ref: currentCollection.where(field, arrayContains: value));
      case WhereOperations.arrayContainsAny:
        return QueryEntityImpl(ref: currentCollection.where(field, arrayContainsAny: value));
      case WhereOperations.whereIn:
        return QueryEntityImpl(ref: currentCollection.where(field, whereIn: value));
      case WhereOperations.whereNotIn:
        return QueryEntityImpl(ref: currentCollection.where(field, whereNotIn: value));
      case WhereOperations.isNull:
        return QueryEntityImpl(ref: currentCollection.where(field, isNull: value));
      default:
        throw Exception('Unknown operation');
    }
  }

  CollectionReference _getCollection(Collections collection) {
    switch (collection) {
      case Collections.ad:
        return FirebaseFirestore.instance.collection('ad').withConverter<AdEntity>(
              fromFirestore: (snapshots, _) => AdEntityImpl.fromJson(snapshots.data()!),
              toFirestore: (ad, _) => (ad as AdEntityImpl).toJson(),
            );
      case Collections.accounts:
        return FirebaseFirestore.instance.collection('accounts').withConverter<AccountEntity>(
              fromFirestore: (snapshots, _) => AccountEntityImpl.fromJson(snapshots.data()!),
              toFirestore: (ad, _) => (ad as AccountEntityImpl).toJson(),
            );
      case Collections.properties:
        return FirebaseFirestore.instance.collection('properties');
    }
  }
}
