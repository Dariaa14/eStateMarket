import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:data/entities_impl/message_entity_impl.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/message_entity.dart';
import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/repositories/chat_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../entities_impl/wrappers/collection_reference_entity_impl.dart';

class ChatRepositoryImpl implements ChatRepository {
  final _currentUserController = StreamController<AccountEntity>.broadcast();
  final _otherUserController = StreamController<AccountEntity>.broadcast();

  @override
  Stream<List<MessageEntity>> getMessages() {
    CollectionReferenceEntity chats =
        CollectionReferenceEntityImpl(collection: Collections.chats, withConverter: false);
    return Rx.combineLatest2(
            _currentUserController.stream, _otherUserController.stream, (sender, receiver) => Tuple2(sender, receiver))
        .switchMap((tuple) {
      final sender = tuple.value1;
      final receiver = tuple.value2;

      final chatDocument = _getChatDocumentId(sender.email, receiver.email);
      final messagesRef = chats.doc(chatDocument).collection('messages');

      return messagesRef.snapshots().asyncMap((querySnapshot) async {
        return querySnapshot.docs().map((doc) {
          final data = doc.data();
          data['timestamp'] = doc.id;
          return MessageEntityImpl.fromJson(data);
        }).toList();
      });
    });
  }

  @override
  Stream<List<AccountEntity>> getChatUsers() {
    CollectionReferenceEntity chats =
        CollectionReferenceEntityImpl(collection: Collections.chats, withConverter: false);
    CollectionReferenceEntity accounts = CollectionReferenceEntityImpl(collection: Collections.accounts);

    return _currentUserController.stream.asyncMap((currentUser) async {
      final documents = await chats.getDocuments();

      final List<AccountEntity> otherUsers = [];

      for (var doc in documents) {
        final docId = doc.id;
        final emails = docId.split('_');
        if (emails.contains(currentUser.email)) {
          final otherEmail = emails.firstWhere((email) => email != currentUser.email);
          final account =
              (await accounts.where('email', WhereOperations.isEqualTo, otherEmail).get<AccountEntity>()).first;
          otherUsers.add(account);
        }
      }

      return otherUsers;
    });
  }

  @override
  void setCurrentUser(AccountEntity user) {
    _currentUserController.add(user);
  }

  @override
  void setOtherUser(AccountEntity user) {
    _otherUserController.add(user);
  }

  String _getChatDocumentId(String email1, String email2) {
    final users = [email1, email2]..sort();
    return '${users[0]}_${users[1]}';
  }
}
