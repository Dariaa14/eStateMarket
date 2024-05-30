import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/entities_impl/wrappers/document_reference_entity_impl.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/favorites_entity.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/entities/wrappers/query_document_snapshot_entity.dart';
import 'package:domain/entities/wrappers/query_snapshot_entity.dart';

import '../ad_enitity_impl.dart';
import '../favorites_entity_impl.dart';
import 'query_document_snapshot_entity_impl.dart';

class QuerySnapshotEntityImpl extends QuerySnapshotEntity {
  final QuerySnapshot<Object?> ref;

  QuerySnapshotEntityImpl({required this.ref});

  @override
  Future<List<T>> transformToList<T>() async {
    List<T> allItems = [];
    for (int index = 0; index < ref.size; index++) {
      T item = ref.docs[index].data() as T;
      if (item is AdEntity) {
        await (item as AdEntityImpl).setReferences();
      }
      if (item is FavoritesEntity) {
        await (item as FavoritesEntityImpl).setReferences();
      }
      allItems.add(item);
    }
    return allItems;
  }

  @override
  List<DocumentReferenceEntity> transformToDocumentReferenceList() {
    List<DocumentReferenceEntity> allItems = [];
    for (int index = 0; index < ref.size; index++) {
      final document = DocumentReferenceEntityImpl(ref: ref.docs[index].reference);

      allItems.add(document);
    }
    return allItems;
  }

  @override
  List<QueryDocumentSnapshotEntity> docs() {
    return ref.docs.map((doc) => QueryDocumentSnapshotEntityImpl(ref: doc)).toList();
  }
}
