import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/message_entity.dart';

abstract class ChatRepository {
  Stream<List<MessageEntity>> getMessages();
  void setChatUsers(AccountEntity sender, AccountEntity receiver);
}
