import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/src/models/message_reaction.dart';

class ReactionWidget extends StatelessWidget {
  const ReactionWidget({
    Key? key,
    required this.reaction,
    this.messageReaction,
  }) : super(key: key);
  final String reaction;
  final MessageReaction? messageReaction;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: messageReaction?.padding ??
            const EdgeInsets.symmetric(vertical: 2.5, horizontal: 4),
        margin: messageReaction?.margin ?? const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: messageReaction?.backgroundColor ?? Colors.grey.shade200,
          borderRadius:
              messageReaction?.borderRadius ?? BorderRadius.circular(18),
          border: Border.all(
            color: messageReaction?.borderColor ?? Colors.white,
            width: messageReaction?.borderWidth ?? 1.5,
          ),
        ),
        child: Text(
          reaction,
          style: TextStyle(fontSize: messageReaction?.size ?? 13),
        ),
      ),
    );
  }
}
