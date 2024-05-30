import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/wrappers/query_document_snapshot_entity.dart';

class QueryDocumentSnapshotEntityImpl implements QueryDocumentSnapshotEntity {
  final QueryDocumentSnapshot ref;

  QueryDocumentSnapshotEntityImpl({required this.ref});

  @override
  Map<String, dynamic> data() {
    return ref.data() as Map<String, dynamic>;
  }

  @override
  String get id => ref.id;
}
