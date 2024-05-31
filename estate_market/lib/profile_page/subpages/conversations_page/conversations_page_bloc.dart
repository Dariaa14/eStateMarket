import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/use_cases/account_use_case.dart';
import 'package:domain/use_cases/chat_use_case.dart';
import 'package:equatable/equatable.dart';

part 'conversations_page_event.dart';
part 'conversations_page_state.dart';

class ConversationsPageBloc extends Bloc<ConversationsPageEvent, ConversationsPageState> {
  final ChatUseCase _chatUseCase = sl.get<ChatUseCase>();
  final AccountUseCase _accountUseCase = sl.get<AccountUseCase>();

  late StreamSubscription<List<String>> _usersSubscription;

  ConversationsPageBloc() : super(const ConversationsPageState()) {
    on<InitConversationsPageEvent>(_onInitConversationsPageEvent);
    on<SetChatUsersEvent>(_onSetChatUsersEvent);
  }

  void _onInitConversationsPageEvent(InitConversationsPageEvent event, Emitter<ConversationsPageState> emit) {
    _usersSubscription = _chatUseCase.usersStream.listen((users) {
      add(SetChatUsersEvent(users: users));
    });
    _chatUseCase.setCurrentUser(_accountUseCase.currentAccount!);
  }

  void _onSetChatUsersEvent(SetChatUsersEvent event, Emitter<ConversationsPageState> emit) {
    emit(state.copyWith(users: event.users));
  }

  @override
  Future<void> close() async {
    _usersSubscription.cancel();
    super.close();
  }
}
