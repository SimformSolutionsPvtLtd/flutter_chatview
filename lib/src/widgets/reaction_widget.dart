import 'package:flutter/material.dart';
import 'package:chat_view/src/models/message_reaction_configuration.dart';

class ReactionWidget extends StatelessWidget {
  const ReactionWidget({
    Key? key,
    required this.reaction,
    this.messageReactionConfig,
    required this.isMessageBySender,
  }) : super(key: key);
  final String reaction;
  final MessageReactionConfiguration? messageReactionConfig;
  final bool isMessageBySender;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: messageReactionConfig?.padding ??
            const EdgeInsets.symmetric(vertical: 1.7, horizontal: 6),
        margin: messageReactionConfig?.margin ??
            EdgeInsets.only(left: isMessageBySender ? 10 : 16),
        decoration: BoxDecoration(
          color: messageReactionConfig?.backgroundColor ?? Colors.grey.shade200,
          borderRadius:
              messageReactionConfig?.borderRadius ?? BorderRadius.circular(16),
          border: Border.all(
            color: messageReactionConfig?.borderColor ?? Colors.white,
            width: messageReactionConfig?.borderWidth ?? 1,
          ),
        ),
        child: Text(
          reaction,
          style: TextStyle(fontSize: messageReactionConfig?.reactionSize ?? 13),
        ),
      ),
    );
  }
}
