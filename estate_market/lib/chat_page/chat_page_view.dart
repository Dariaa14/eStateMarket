import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/message_entity.dart';
import 'package:data/entities_impl/message_entity_impl.dart';
import 'package:estate_market/chat_page/messages_tiles.dart';
import 'package:estate_market/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ChatPageView extends StatelessWidget {
  final AccountEntity receiver;
  const ChatPageView({super.key, required this.receiver});

  @override
  Widget build(BuildContext context) {
    final MessageEntity message1 = MessageEntityImpl(
      message: '''
Hello!
How are you doing today?''',
      isSenderFirst: true,
      timestamp: DateTime.now(),
    );
    final MessageEntity message2 = MessageEntityImpl(
      message: 'Hello back!',
      isSenderFirst: false,
      timestamp: DateTime.now(),
    );
    final List<MessageEntity> messages = [
      message1,
      message2,
      message1,
      message2,
      message1,
      message2,
      message1,
      message2,
      message1,
      message2,
      message1,
      message2,
      message1,
      message2
    ];

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(receiver.email),
        ),
        body: Stack(
          children: [
            Container(
              color: Theme.of(context).colorScheme.background,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: ListView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == messages.length) {
                    return const SizedBox(height: 70);
                  }
                  final message = messages[index];
                  if (message.isSenderFirst) {
                    return SenderMessageTile(
                      message: message,
                    );
                  }
                  return ReceiverMessageTile(
                    message: message,
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                height: 70,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Expanded(
                      child: CustomTextfield(
                        hintText: 'Type a message...',
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
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
