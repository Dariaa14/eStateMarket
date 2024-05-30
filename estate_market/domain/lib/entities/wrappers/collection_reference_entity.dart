import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/entities/wrappers/query_entity.dart';

import 'query_snapshot_entity.dart';

enum Collections { ad, accounts, properties, favorites, landmarks, chats }

enum WhereOperations {
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
  arrayContains,
  arrayContainsAny,
  whereIn,
  whereNotIn,
  isNull
}

abstract class CollectionReferenceEntity {
  Future<DocumentReferenceEntity> add(Map<String, dynamic> map);
  Future<List<T>> get<T>();
  Future<List<DocumentReferenceEntity>> getDocuments<T>();
  QueryEntity where<T>(String field, WhereOperations operation, dynamic value);
  Stream<QuerySnapshotEntity> snapshots();
  DocumentReferenceEntity doc(String path);
}
