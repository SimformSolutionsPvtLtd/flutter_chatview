import 'package:flutter/material.dart';

import 'package:flutter_chat_ui/src/extensions/date_time_extension.dart';

class ChatGroupHeader extends StatelessWidget {
  const ChatGroupHeader({
    Key? key,
    required this.day,
    this.chatGroupHeaderPadding,
  }) : super(key: key);

  final DateTime day;
  final EdgeInsetsGeometry? chatGroupHeaderPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          chatGroupHeaderPadding ?? const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        day.getDay,
        textAlign: TextAlign.center,
      ),
    );
  }
}
