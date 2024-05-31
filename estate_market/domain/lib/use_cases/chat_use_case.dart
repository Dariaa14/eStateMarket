import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/message_entity.dart';
import 'package:domain/repositories/chat_repository.dart';
import 'package:rxdart/rxdart.dart';

class ChatUseCase {
  final ChatRepository _chatRepository;
  final BehaviorSubject<List<MessageEntity>> _messagesController = BehaviorSubject();
  final BehaviorSubject<List<AccountEntity>> _usersController = BehaviorSubject();

  ChatUseCase({required ChatRepository chatRepository}) : _chatRepository = chatRepository {
    _messagesController.addStream(_chatRepository.getMessages());
    _usersController.addStream(_chatRepository.getChatUsers());
  }

  Stream<List<MessageEntity>> get messagesStream => _messagesController.stream;
  Stream<List<AccountEntity>> get usersStream => _usersController.stream;

  void setOtherUser(AccountEntity user) {
    _chatRepository.setOtherUser(user);
  }

  void setCurrentUser(AccountEntity user) {
    _chatRepository.setCurrentUser(user);
  }

  void dispose() {
    _messagesController.close();
    _usersController.close();
  }
}
