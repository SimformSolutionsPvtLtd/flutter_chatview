import 'package:flutter/material.dart';

import 'package:flutter_chat_ui/src/models/models.dart';

import 'share_icon.dart';

class ImageMessageView extends StatelessWidget {
  const ImageMessageView({
    Key? key,
    required this.message,
    required this.isCurrentUser,
    this.imageMessage,
  }) : super(key: key);

  final Message message;
  final bool isCurrentUser;
  final ImageMessage? imageMessage;

  @override
  Widget build(BuildContext context) {
    final iconButton =
        ShareIcon(shareIconConfiguration: imageMessage?.shareIcon);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (isCurrentUser) iconButton,
        GestureDetector(
          onTap: imageMessage?.onImageViewTap,
          child: Container(
            padding: imageMessage?.padding ?? EdgeInsets.zero,
            margin: imageMessage?.margin ??
                EdgeInsets.only(
                  top: 6,
                  right: isCurrentUser ? 6 : 0,
                  left: isCurrentUser ? 0 : 6,
                  bottom: message.reaction.isNotEmpty ? 15 : 0,
                ),
            height: imageMessage?.height ?? 170,
            width: imageMessage?.width ?? 150,
            child: ClipRRect(
              borderRadius:
                  imageMessage?.borderRadius ?? BorderRadius.circular(14),
              child: Image.network(
                message.message,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        if (!isCurrentUser) iconButton,
      ],
    );
  }
}
