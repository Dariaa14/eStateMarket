part of 'chat_page_bloc.dart';

abstract class ChatPageEvent {}

class InitChatPageEvent extends ChatPageEvent {
  final AccountEntity receiver;

  InitChatPageEvent({required this.receiver});
}

class MessageSentEvent extends ChatPageEvent {
  final String message;
  final AccountEntity receiver;

  MessageSentEvent({required this.message, required this.receiver});
}

class SetMessagesEvent extends ChatPageEvent {
  final List<MessageEntity> messages;

  SetMessagesEvent({required this.messages});
}
