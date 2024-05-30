import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/message_entity.dart';
import 'package:domain/repositories/chat_repository.dart';
import 'package:rxdart/rxdart.dart';

class ChatUseCase {
  final ChatRepository _chatRepository;
  final BehaviorSubject<List<MessageEntity>> _messagesController = BehaviorSubject();

  ChatUseCase({required ChatRepository chatRepository}) : _chatRepository = chatRepository {
    _messagesController.addStream(_chatRepository.getMessages());
  }

  Stream<List<MessageEntity>> get messagesStream => _messagesController.stream;

  void setChatUsers(AccountEntity sender, AccountEntity receiver) {
    _chatRepository.setChatUsers(sender, receiver);
  }
}
