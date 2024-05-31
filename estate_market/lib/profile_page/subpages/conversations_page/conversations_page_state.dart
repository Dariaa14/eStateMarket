part of 'conversations_page_bloc.dart';

class ConversationsPageState extends Equatable {
  final List<AccountEntity> users;
  const ConversationsPageState({this.users = const []});

  ConversationsPageState copyWith({List<AccountEntity>? users}) {
    return ConversationsPageState(users: users ?? this.users);
  }

  @override
  List<Object> get props => [users];
}
