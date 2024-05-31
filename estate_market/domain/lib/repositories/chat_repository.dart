import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/message_entity.dart';

abstract class ChatRepository {
  Stream<List<MessageEntity>> getMessages();
  Stream<List<AccountEntity>> getChatUsers();

  void setCurrentUser(AccountEntity user);
  void setOtherUser(AccountEntity user);
}
