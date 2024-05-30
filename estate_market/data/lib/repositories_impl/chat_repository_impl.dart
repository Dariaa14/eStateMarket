import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:data/entities_impl/message_entity_impl.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/message_entity.dart';
import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/repositories/chat_repository.dart';

import '../entities_impl/wrappers/collection_reference_entity_impl.dart';

class ChatRepositoryImpl implements ChatRepository {
  final _accountsController = StreamController<Tuple2<AccountEntity, AccountEntity>>.broadcast();
  final _currentUserController = StreamController<AccountEntity>.broadcast();

  @override
  Stream<List<MessageEntity>> getMessages() {
    CollectionReferenceEntity chats =
        CollectionReferenceEntityImpl(collection: Collections.chats, withConverter: false);
    return _accountsController.stream.asyncExpand((accounts) async* {
      final user1 = accounts.head;
      final user2 = accounts.tail;
      final chatDocument = _getChatDocumentId(user1.email, user2.email);
      final messagesRef = chats.doc(chatDocument).collection('messages');

      yield* messagesRef.snapshots().map((querySnapshot) {
        return querySnapshot.docs().map((doc) {
          final data = doc.data();
          data['timestamp'] = doc.id;
          return MessageEntityImpl.fromJson(data);
        }).toList();
      });
    });
  }

  @override
  Stream<List<String>> getChatUsers() {
    CollectionReferenceEntity chats =
        CollectionReferenceEntityImpl(collection: Collections.chats, withConverter: false);
    return _currentUserController.stream.asyncExpand((currentUser) async* {
      final documents = await chats.getDocuments();

      final otherUsers = <String>{};
      for (var doc in documents) {
        final docId = doc.id;
        final emails = docId.split('_');
        if (emails.contains(currentUser.email)) {
          final otherEmail = emails.firstWhere((email) => email != currentUser.email);

          otherUsers.add(otherEmail);
        }
      }

      yield otherUsers.toList();
    });
  }

  @override
  void setChatUsers(AccountEntity sender, AccountEntity receiver) {
    _accountsController.add(Tuple2(sender, receiver));
    setCurrentUser(sender);
  }

  @override
  void setCurrentUser(AccountEntity user) {
    _currentUserController.add(user);
  }

  String _getChatDocumentId(String email1, String email2) {
    final users = [email1, email2]..sort();
    return '${users[0]}_${users[1]}';
  }
}
