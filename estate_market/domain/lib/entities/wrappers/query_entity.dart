import 'collection_reference_entity.dart';

abstract class QueryEntity {
  Future<List<T>> get<T>();
  QueryEntity where<T>(String field, WhereOperations operation, dynamic value);
}
