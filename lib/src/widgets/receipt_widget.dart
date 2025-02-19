import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiptWidget extends StatelessWidget {
  final Message message;
  final bool isMessageByCurrentUser;
  final ReceiptsWidgetConfig? receiptWidgetConfig;

  const ReceiptWidget({
    super.key,
    required this.message,
    required this.receiptWidgetConfig,
    required this.isMessageByCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final time = message.createdAt.toLocal();
    final timeFormat = receiptWidgetConfig?.timeFormat ?? DateFormat('hh:mm a');

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          timeFormat.format(time),
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: Colors.grey),
        ),
        if (isMessageByCurrentUser) SizedBox(width: 5),
        if (isMessageByCurrentUser)
          ValueListenableBuilder(
            valueListenable: message.statusNotifier,
            builder: (context, MessageStatus value, child) {
              switch (value) {
                case MessageStatus.undelivered:
                  return Icon(
                    Icons.remove_road,
                    color: Colors.red,
                    size: 15,
                  );
                case MessageStatus.read:
                  return Icon(Icons.speed, color: Colors.green, size: 15);
                case MessageStatus.delivered:
                  return Icon(Icons.speed, color: Colors.orange, size: 15);
                case MessageStatus.pending:
                  return Icon(Icons.speed, color: Colors.grey, size: 10);
              }
            },
          ),
      ],
    );
  }
}
