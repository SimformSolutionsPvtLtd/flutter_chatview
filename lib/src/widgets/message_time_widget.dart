import 'package:flutter/material.dart';
import 'package:chat_view/src/extensions/extensions.dart';

class MessageTimeWidget extends StatelessWidget {
  const MessageTimeWidget({
    Key? key,
    required this.messageTime,
    required this.isCurrentUser,
    this.messageTimeTextStyle,
    this.messageTimeIconColor,
  }) : super(key: key);
  final DateTime messageTime;
  final bool isCurrentUser;
  final TextStyle? messageTimeTextStyle;
  final Color? messageTimeIconColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: messageTimeIconColor ?? Colors.black,
                ),
              ),
              child: Icon(
                isCurrentUser ? Icons.arrow_forward : Icons.arrow_back,
                size: 10,
                color: messageTimeIconColor ?? Colors.black,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              messageTime.getTimeFromDateTime,
              style: messageTimeTextStyle ?? const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
