import 'package:domain/entities/wrappers/document_reference_entity.dart';

abstract class QuerySnapshotEntity {
  Future<List<T>> transformToList<T>();
  List<DocumentReferenceEntity> transformToDocumentReferenceList();
}
