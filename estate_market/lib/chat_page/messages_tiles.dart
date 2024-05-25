import 'package:domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class SenderMessageTile extends StatelessWidget {
  final MessageEntity message;
  const SenderMessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Text(message.message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
          ),
        ],
      ),
    );
  }
}

class ReceiverMessageTile extends StatelessWidget {
  final MessageEntity message;
  const ReceiverMessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Text(message.message,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
