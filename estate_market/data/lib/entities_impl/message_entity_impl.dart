import 'package:domain/entities/message_entity.dart';

class MessageEntityImpl implements MessageEntity {
  @override
  String message;

  @override
  bool isSenderFirst;

  @override
  DateTime timestamp;

  MessageEntityImpl({required this.message, required this.isSenderFirst, required this.timestamp});

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isSenderFirst': isSenderFirst,
    };
  }

  factory MessageEntityImpl.fromJson(Map<String, Object?> json) {
    return MessageEntityImpl(
      message: json['message'] as String,
      isSenderFirst: json['isSenderFirst'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}
