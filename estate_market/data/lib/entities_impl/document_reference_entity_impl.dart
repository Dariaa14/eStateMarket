import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/document_reference_entity.dart';

class DocumentReferenceEntityImpl implements DocumentReferenceEntity {
  DocumentReference ref;

  DocumentReferenceEntityImpl({required this.ref});
}
