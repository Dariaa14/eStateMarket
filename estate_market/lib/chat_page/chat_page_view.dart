import 'package:domain/entities/account_entity.dart';
import 'package:estate_market/chat_page/chat_page_bloc.dart';
import 'package:estate_market/chat_page/messages_tiles.dart';
import 'package:estate_market/main_page/main_page_bloc.dart';
import 'package:estate_market/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatPageView extends StatelessWidget {
  final AccountEntity receiver;
  final TextEditingController _controller = TextEditingController();
  ChatPageView({super.key, required this.receiver});

  @override
  Widget build(BuildContext context) {
    final MainPageBloc mainBloc = BlocProvider.of<MainPageBloc>(context);
    final ChatPageBloc chatBloc = ChatPageBloc();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(receiver.email),
        ),
        body: Stack(
          children: [
            BlocBuilder<ChatPageBloc, ChatPageState>(
              bloc: chatBloc..add(InitChatPageEvent(receiver: receiver)),
              builder: (context, state) {
                return Container(
                  color: Theme.of(context).colorScheme.background,
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: ListView.builder(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: state.messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.messages.length) {
                        return const SizedBox(height: 70);
                      }

                      final message = state.messages[index];
                      final users = [mainBloc.currentAccount!.email, receiver.email]..sort();
                      if (message.isSenderFirst == (mainBloc.currentAccount!.email == users.first)) {
                        return SenderMessageTile(
                          message: message,
                        );
                      }
                      return ReceiverMessageTile(
                        message: message,
                      );
                    },
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                height: 70,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextfield(
                        controller: _controller,
                        hintText: AppLocalizations.of(context)!.typeMessage,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        chatBloc.add(MessageSentEvent(
                          message: _controller.text,
                          receiver: receiver,
                        ));
                        _controller.clear();
                      },
                      icon: const Icon(Icons.send),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
