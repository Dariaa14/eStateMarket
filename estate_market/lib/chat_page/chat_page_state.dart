part of 'chat_page_bloc.dart';

class ChatPageState extends Equatable {
  final List<MessageEntity> messages;

  const ChatPageState({this.messages = const []});

  ChatPageState copyWith({List<MessageEntity>? messages}) {
    return ChatPageState(messages: messages ?? this.messages);
  }

  @override
  List<Object> get props => [messages];
}
