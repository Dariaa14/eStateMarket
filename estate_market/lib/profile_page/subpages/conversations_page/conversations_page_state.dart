part of 'conversations_page_bloc.dart';

class ConversationsPageState extends Equatable {
  final List<String> users;
  const ConversationsPageState({this.users = const []});

  ConversationsPageState copyWith({List<String>? users}) {
    return ConversationsPageState(users: users ?? this.users);
  }

  @override
  List<Object> get props => [users];
}
