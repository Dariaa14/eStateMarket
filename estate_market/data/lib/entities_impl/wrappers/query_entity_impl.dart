import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/entities_impl/wrappers/query_snapshot_entity_impl.dart';
import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/entities/wrappers/query_entity.dart';
import 'package:domain/entities/wrappers/query_snapshot_entity.dart';

class QueryEntityImpl implements QueryEntity {
  final Query ref;

  QueryEntityImpl({required this.ref});

  @override
  Future<List<T>> get<T>() async {
    final QuerySnapshotEntity items = QuerySnapshotEntityImpl(ref: await ref.get());
    return items.transformToList();
  }

  @override
  QueryEntity where<T>(String field, WhereOperations operation, value) {
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
}
