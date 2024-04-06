import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/entities_impl/favorites_entity_impl.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/favorites_entity.dart';
import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/entities/wrappers/query_entity.dart';
import 'package:domain/entities/wrappers/query_snapshot_entity.dart';

import '../account_entity_impl.dart';
import '../ad_enitity_impl.dart';
import 'document_reference_entity_impl.dart';
import 'query_entity_impl.dart';
import 'query_snapshot_entity_impl.dart';

class CollectionReferenceEntityImpl extends CollectionReferenceEntity {
  late final CollectionReference ref;

  CollectionReferenceEntityImpl({required Collections collection, bool withConverter = true}) {
    ref = _getCollection(collection, withConverter: withConverter);
  }

  @override
  Future<DocumentReferenceEntity> add(Map<String, dynamic> map) async {
    DocumentReference docRef = await ref.add(map);
    return DocumentReferenceEntityImpl(ref: docRef);
  }

  @override
  Future<List<T>> get<T>() async {
    final QuerySnapshotEntity items = QuerySnapshotEntityImpl(ref: await ref.get());
    return items.transformToList();
  }

  @override
  Future<List<DocumentReferenceEntity>> getDocuments<T>() async {
    final QuerySnapshotEntity items = QuerySnapshotEntityImpl(ref: await ref.get());
    return items.transformToDocumentReferenceList();
  }

  @override
  QueryEntity where<T>(String field, WhereOperations operation, dynamic value) {
    switch (operation) {
      case WhereOperations.isEqualTo:
        return QueryEntityImpl(ref: ref.where(field, isEqualTo: value));
      case WhereOperations.isNotEqualTo:
        return QueryEntityImpl(ref: ref.where(field, isNotEqualTo: value));
      case WhereOperations.isLessThan:
        return QueryEntityImpl(ref: ref.where(field, isLessThan: value));
      case WhereOperations.isLessThanOrEqualTo:
        return QueryEntityImpl(ref: ref.where(field, isLessThanOrEqualTo: value));
      case WhereOperations.isGreaterThan:
        return QueryEntityImpl(ref: ref.where(field, isGreaterThan: value));
      case WhereOperations.isGreaterThanOrEqualTo:
        return QueryEntityImpl(ref: ref.where(field, isGreaterThanOrEqualTo: value));
      case WhereOperations.arrayContains:
        return QueryEntityImpl(ref: ref.where(field, arrayContains: value));
      case WhereOperations.arrayContainsAny:
        return QueryEntityImpl(ref: ref.where(field, arrayContainsAny: value));
      case WhereOperations.whereIn:
        return QueryEntityImpl(ref: ref.where(field, whereIn: value));
      case WhereOperations.whereNotIn:
        return QueryEntityImpl(ref: ref.where(field, whereNotIn: value));
      case WhereOperations.isNull:
        return QueryEntityImpl(ref: ref.where(field, isNull: value));
      default:
        throw Exception('Unknown operation');
    }
  }

  CollectionReference _getCollection(Collections collection, {bool withConverter = true}) {
    switch (collection) {
      case Collections.ad:
        if (withConverter) {
          return FirebaseFirestore.instance.collection('ad').withConverter<AdEntity>(
                fromFirestore: (snapshots, _) => AdEntityImpl.fromJson(snapshots.data()!),
                toFirestore: (ad, _) => (ad as AdEntityImpl).toJson(),
              );
        }
        return FirebaseFirestore.instance.collection('ad');
      case Collections.accounts:
        if (withConverter) {
          return FirebaseFirestore.instance.collection('accounts').withConverter<AccountEntity>(
                fromFirestore: (snapshots, _) => AccountEntityImpl.fromJson(snapshots.data()!),
                toFirestore: (account, _) => (account as AccountEntityImpl).toJson(),
              );
        }
        return FirebaseFirestore.instance.collection('accounts');
      case Collections.properties:
        return FirebaseFirestore.instance.collection('properties');
      case Collections.favorites:
        if (withConverter) {
          return FirebaseFirestore.instance.collection('favorites').withConverter<FavoritesEntity>(
                fromFirestore: (snapshots, _) => FavoritesEntityImpl.fromJson(snapshots.data()!),
                toFirestore: (favorites, _) => (favorites as FavoritesEntityImpl).toJson(),
              );
        }
        return FirebaseFirestore.instance.collection('favorites');
    }
  }
}
