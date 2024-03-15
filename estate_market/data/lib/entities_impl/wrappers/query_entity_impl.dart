import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/entities_impl/wrappers/query_snapshot_entity_impl.dart';
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
}
