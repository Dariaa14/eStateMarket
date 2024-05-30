part of 'conversations_page_bloc.dart';

abstract class ConversationsPageEvent {}

class InitConversationsPageEvent extends ConversationsPageEvent {}

class SetChatUsersEvent extends ConversationsPageEvent {
  final List<String> users;

  SetChatUsersEvent({required this.users});
}
