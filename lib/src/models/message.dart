import 'package:chat_view/src/models/reply_message.dart';
import 'package:chat_view/src/values/enumaration.dart';

class Message {
  final String id;
  final String message;
  final DateTime createdAt;
  final String sendBy;
  final ReplyMessage replyMessage;
  final String reaction;
  final MessageType messageType;

  Message({
    this.id = '',
    required this.message,
    required this.createdAt,
    required this.sendBy,
    ReplyMessage? replyMessage,
    this.reaction = '',
    this.messageType = MessageType.text,
  }) : replyMessage = replyMessage ?? ReplyMessage();

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        message: json["message"],
        createdAt: json["createdAt"],
        sendBy: json["sendBy"],
        replyMessage: ReplyMessage.fromJson(json["reply_message"]),
        reaction: json["reaction"] ?? '',
        messageType: json["message_type"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'createdAt': createdAt,
        'sendBy': sendBy,
        'reply_message': replyMessage.toJson(),
        'reaction': reaction,
        'message_type': messageType,
      };
}
