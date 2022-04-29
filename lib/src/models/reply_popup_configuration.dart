import 'package:flutter/material.dart';

import '../values/typedefs.dart';
import 'message.dart';

class ReplyPopupConfiguration {
  final Color? backgroundColor;
  final Widget Function(Message message, bool sendByCurrentUser)?
      replyPopupBuilder;
  final MessageCallBack? onUnsendTap;
  final MessageCallBack? onReplyTap;
  final VoidCallBack? onReportTap;
  final VoidCallBack? onMoreTap;
  final TextStyle? buttonTextStyle;
  final Color? topBorderColor;

  ReplyPopupConfiguration({
    this.buttonTextStyle,
    this.topBorderColor,
    this.onUnsendTap,
    this.onReplyTap,
    this.onReportTap,
    this.onMoreTap,
    this.backgroundColor,
    this.replyPopupBuilder,
  });
}
