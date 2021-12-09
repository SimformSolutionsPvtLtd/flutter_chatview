import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/src/models/image_message.dart';

class ShareIcon extends StatelessWidget {
  const ShareIcon({
    Key? key,
    this.shareIconConfiguration,
  }) : super(key: key);

  final ShareIconConfiguration? shareIconConfiguration;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: shareIconConfiguration?.onPressed,
      padding: shareIconConfiguration?.margin ?? const EdgeInsets.all(8.0),
      icon: shareIconConfiguration?.icon ??
          Container(
            alignment: Alignment.center,
            padding: shareIconConfiguration?.padding ?? const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: shareIconConfiguration?.backgroundColor ??
                  Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.send,
              color: Colors.black,
              size: 16,
            ),
          ),
    );
  }
}
