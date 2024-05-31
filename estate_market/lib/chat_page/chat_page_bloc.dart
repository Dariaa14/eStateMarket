import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/message_entity.dart';
import 'package:domain/use_cases/account_use_case.dart';
import 'package:domain/use_cases/chat_use_case.dart';
import 'package:domain/use_cases/database_use_case.dart';
import 'package:equatable/equatable.dart';

part 'chat_page_event.dart';
part 'chat_page_state.dart';

class ChatPageBloc extends Bloc<ChatPageEvent, ChatPageState> {
  final DatabaseUseCase _databaseUseCase = sl.get<DatabaseUseCase>();
  final AccountUseCase _accountUseCase = sl.get<AccountUseCase>();
  final ChatUseCase _chatUseCase = sl.get<ChatUseCase>();

  late StreamSubscription<List<MessageEntity>> _messagesSubscription;

  ChatPageBloc() : super(const ChatPageState()) {
    on<InitChatPageEvent>(_initChatPageEventHandler);
    on<MessageSentEvent>(_messageSentEventHandler);

    on<SetMessagesEvent>(_setMessagesEventHandler);
  }

  void _initChatPageEventHandler(InitChatPageEvent event, Emitter<ChatPageState> emit) {
    _messagesSubscription = _chatUseCase.messagesStream.listen((messages) {
      add(SetMessagesEvent(messages: messages));
    });
    _chatUseCase.setCurrentUser(_accountUseCase.currentAccount!);
    _chatUseCase.setOtherUser(event.receiver);
  }

  void _messageSentEventHandler(MessageSentEvent event, Emitter<ChatPageState> emit) async {
    await _databaseUseCase.insertMessage(
        message: event.message, sender: _accountUseCase.currentAccount!, receiver: event.receiver);
  }

  void _setMessagesEventHandler(SetMessagesEvent event, Emitter<ChatPageState> emit) {
    emit(state.copyWith(messages: event.messages));
  }

  @override
  Future<void> close() async {
    _chatUseCase.dispose();
    _messagesSubscription.cancel();
    super.close();
  }
}
