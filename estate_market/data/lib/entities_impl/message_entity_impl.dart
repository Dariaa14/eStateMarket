import 'package:domain/entities/message_entity.dart';

class MessageEntityImpl implements MessageEntity {
  @override
  String message;

  @override
  bool isSenderFirst;

  @override
  DateTime timestamp;

  MessageEntityImpl({required this.message, required this.isSenderFirst, required this.timestamp});
}
