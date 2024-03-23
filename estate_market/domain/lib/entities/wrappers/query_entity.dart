import 'collection_reference_entity.dart';
import 'document_reference_entity.dart';

abstract class QueryEntity {
  Future<List<T>> get<T>();
  Future<List<DocumentReferenceEntity>> getDocuments<T>();
  QueryEntity where<T>(String field, WhereOperations operation, dynamic value);
}
