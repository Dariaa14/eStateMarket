import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';

class DocumentReferenceEntityImpl implements DocumentReferenceEntity {
  DocumentReference ref;

  DocumentReferenceEntityImpl({required this.ref});

  @override
  Future<void> set(Map<String, Object?> json) async {
    await ref.set(json);
  }

  @override
  Future<void> delete() async {
    await ref.delete();
  }
}
