import 'package:chat_view/src/models/models.dart';

class MessageConfiguration {
  final ImageMessageConfiguration? imageMessageConfig;
  final MessageReactionConfiguration? messageReactionConfig;
  final EmojiMessageConfiguration? emojiMessageConfig;

  MessageConfiguration({
    this.imageMessageConfig,
    this.messageReactionConfig,
    this.emojiMessageConfig,
  });
}
