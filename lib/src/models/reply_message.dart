import '../values/enumaration.dart';

class ReplyMessage {
  final String message;
  final String replyBy;
  final String replyTo;
  final MessageType messageType;

  ReplyMessage({
    this.message = '',
    this.replyTo = '',
    this.replyBy = '',
    this.messageType = MessageType.text,
  });

  factory ReplyMessage.fromJson(Map<String, dynamic> json) => ReplyMessage(
        message: json['message'],
        replyBy: json['replyBy'],
        replyTo: json['replyTo'],
        messageType: json["message_type"],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'replyBy': replyBy,
        'replyTo': replyTo,
        'message_type': messageType,
      };
}
