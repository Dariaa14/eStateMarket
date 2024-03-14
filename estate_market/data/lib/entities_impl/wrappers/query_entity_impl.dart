import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/wrappers/query_entity.dart';

import '../ad_enitity_impl.dart';

class QueryEntityImpl implements QueryEntity {
  final Query ref;

  QueryEntityImpl({required this.ref});

  @override
  Future<List<T>> get<T>() async {
    final items = await ref.get();
    List<T> allItems = [];
    for (int index = 0; index < items.size; index++) {
      T item = items.docs[index].data() as T;
      if (T is AdEntity) {
        await (item as AdEntityImpl).setProperty();
      }
      allItems.add(item);
    }
    return allItems;
  }
}
