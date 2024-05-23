import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';

class DocumentReferenceEntityImpl implements DocumentReferenceEntity {
  DocumentReference ref;

  DocumentReferenceEntityImpl({required this.ref});

  @override
  Future<void> set(Map<String, Object?> json) async {
    await ref.set(json, SetOptions(merge: true));
  }

  @override
  Future<void> delete() async {
    await ref.delete();
  }

  @override
  void listen({required void Function() onModify, required void Function() onDelete}) {
    ref.snapshots().listen((refSnapshot) {
      if (refSnapshot.exists) {
        onModify();
      } else {
        onDelete();
      }
    });
  }
}
