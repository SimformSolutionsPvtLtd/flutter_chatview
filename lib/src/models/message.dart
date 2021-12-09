import 'package:flutter_chat_ui/src/models/reply_message.dart';

class Message {
  final String id;
  final String message;
  final DateTime createdAt;
  final String sendBy;
  final ReplyMessage replyMessage;
  final String reaction;

  Message({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.sendBy,
    ReplyMessage? replyMessage,
    this.reaction = '',
  }) : replyMessage = replyMessage ?? ReplyMessage();

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        message: json["message"],
        createdAt: json["createdAt"],
        sendBy: json["sendBy"],
        replyMessage: ReplyMessage.fromJson(json["reply_message"]),
        reaction: json["reaction"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'createdAt': createdAt,
        'sendBy': sendBy,
        'reply_message': replyMessage.toJson(),
        'reaction': reaction,
      };
}
