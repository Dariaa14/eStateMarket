import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_page_event.dart';
part 'chat_page_state.dart';

class ChatPageBloc extends Bloc<ChatPageEvent, ChatPageState> {
  ChatPageBloc() : super(const ChatPageState());
}
