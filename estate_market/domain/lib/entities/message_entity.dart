abstract class MessageEntity {
  final String message;

  final bool isSenderFirst;
  final DateTime timestamp;

  MessageEntity({required this.message, required this.isSenderFirst, required this.timestamp});
}
