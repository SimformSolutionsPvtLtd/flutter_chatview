import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:chat_view/src/extensions/extensions.dart';
import 'package:chat_view/src/models/models.dart';

import 'share_icon.dart';
import 'reaction_widget.dart';

class ImageMessageView extends StatelessWidget {
  const ImageMessageView({
    Key? key,
    required this.message,
    required this.isMessageBySender,
    this.imageMessageConfig,
    this.messageReactionConfig,
  }) : super(key: key);

  final Message message;
  final bool isMessageBySender;
  final ImageMessageConfiguration? imageMessageConfig;
  final MessageReactionConfiguration? messageReactionConfig;

  String get imageUrl => message.message;

  Widget get iconButton => ShareIcon(
        shareIconConfig: imageMessageConfig?.shareIconConfig,
        imageUrl: imageUrl,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          isMessageBySender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (isMessageBySender) iconButton,
        Stack(
          children: [
            GestureDetector(
              onTap: () => imageMessageConfig?.onTap != null
                  ? imageMessageConfig?.onTap!(imageUrl)
                  : null,
              child: Container(
                padding: imageMessageConfig?.padding ?? EdgeInsets.zero,
                margin: imageMessageConfig?.margin ??
                    EdgeInsets.only(
                      top: 6,
                      right: isMessageBySender ? 6 : 0,
                      left: isMessageBySender ? 0 : 6,
                      bottom: message.reaction.isNotEmpty ? 15 : 0,
                    ),
                height: imageMessageConfig?.height ?? 200,
                width: imageMessageConfig?.width ?? 150,
                child: ClipRRect(
                  borderRadius: imageMessageConfig?.borderRadius ??
                      BorderRadius.circular(14),
                  child: imageUrl.fromMemory
                      ? Image.memory(
                          base64Decode(imageUrl
                              .substring(imageUrl.indexOf('base64') + 7)),
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          imageUrl,
                          fit: BoxFit.fitHeight,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
            if (message.reaction.isNotEmpty)
              ReactionWidget(
                isMessageBySender: isMessageBySender,
                reaction: message.reaction.toString(),
                messageReactionConfig: messageReactionConfig,
              ),
          ],
        ),
        if (!isMessageBySender) iconButton,
      ],
    );
  }
}
