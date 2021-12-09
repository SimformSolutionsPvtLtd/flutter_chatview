import 'package:flutter/material.dart';

import 'package:chat_view/src/extensions/extensions.dart';
import 'package:chat_view/src/models/models.dart';
import 'package:chat_view/src/utils/package_strings.dart';

import '../utils/constants.dart';
import 'vertical_line.dart';

class ReplyMessageWidget extends StatelessWidget {
  const ReplyMessageWidget({
    Key? key,
    required this.message,
    this.repliedMessageConfig,
    required this.sender,
    required this.receiver,
  }) : super(key: key);

  final Message message;
  final RepliedMessageConfiguration? repliedMessageConfig;
  final ChatUser sender;
  final ChatUser receiver;

  bool get _replyBySender => message.replyMessage.replyBy == sender.id;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final replyMessage = message.replyMessage.message;
    final replyBy = _replyBySender ? PackageStrings.you : receiver.name;
    return Container(
      margin: repliedMessageConfig?.margin ??
          const EdgeInsets.only(
            right: horizontalPadding,
            left: horizontalPadding,
            bottom: 4,
          ),
      constraints:
          BoxConstraints(maxWidth: repliedMessageConfig?.maxWidth ?? 280),
      child: Column(
        crossAxisAlignment:
            _replyBySender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "${PackageStrings.repliedBy} $replyBy",
            style: repliedMessageConfig?.replyTitleTextStyle ??
                textTheme.bodyText2!.copyWith(fontSize: 14, letterSpacing: 0.3),
          ),
          const SizedBox(height: 6),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: _replyBySender
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (!_replyBySender)
                  VerticalLine(
                    verticalBarWidth: repliedMessageConfig?.verticalBarWidth,
                    verticalBarColor: repliedMessageConfig?.verticalBarColor,
                    rightPadding: 4,
                  ),
                Flexible(
                  child: Opacity(
                    opacity: repliedMessageConfig?.opacity ?? 0.8,
                    child: replyMessage.isImageUrl
                        ? Container(
                            height: repliedMessageConfig
                                    ?.repliedImageMessageHeight ??
                                100,
                            width: repliedMessageConfig
                                    ?.repliedImageMessageWidth ??
                                80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(replyMessage),
                                fit: BoxFit.fill,
                              ),
                              borderRadius:
                                  repliedMessageConfig?.borderRadius ??
                                      BorderRadius.circular(14),
                            ),
                          )
                        : Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    repliedMessageConfig?.maxWidth ?? 280),
                            padding: repliedMessageConfig?.padding ??
                                const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: _borderRadius(replyMessage),
                              color: repliedMessageConfig?.backgroundColor ??
                                  Colors.grey.shade500,
                            ),
                            child: Text(
                              replyMessage,
                              style: repliedMessageConfig?.textStyle ??
                                  textTheme.bodyText2!
                                      .copyWith(color: Colors.black),
                            ),
                          ),
                  ),
                ),
                if (_replyBySender)
                  VerticalLine(
                    verticalBarWidth: repliedMessageConfig?.verticalBarWidth,
                    verticalBarColor: repliedMessageConfig?.verticalBarColor,
                    leftPadding: 4,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BorderRadiusGeometry _borderRadius(String replyMessage) => _replyBySender
      ? repliedMessageConfig?.borderRadius ??
          (replyMessage.length < 37
              ? BorderRadius.circular(replyBorderRadius1)
              : BorderRadius.circular(replyBorderRadius2))
      : repliedMessageConfig?.borderRadius ??
          (replyMessage.length < 29
              ? BorderRadius.circular(replyBorderRadius1)
              : BorderRadius.circular(replyBorderRadius2));
}
