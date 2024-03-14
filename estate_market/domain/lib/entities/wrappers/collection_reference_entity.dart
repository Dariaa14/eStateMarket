import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/entities/wrappers/query_entity.dart';

enum Collections { ad, accounts, properties }

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
  Future<DocumentReferenceEntity> add(Collections collection, Map<String, dynamic> map);
  Future<List<T>> get<T>(Collections collection);
  QueryEntity where<T>(Collections collection, String field, WhereOperations operation, dynamic value);
}
