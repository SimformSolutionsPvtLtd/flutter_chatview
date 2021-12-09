class ReplyMessage {
  final String message;
  final String replyTo;

  ReplyMessage({
    this.message = '',
    this.replyTo = '',
  });

  factory ReplyMessage.fromJson(Map<String, dynamic> json) => ReplyMessage(
        message: json['message'],
        replyTo: json['replyTo'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'replyTo': replyTo,
      };
}
