import 'package:flutter/material.dart';

class SendMessageConfiguration {
  final Color? textFieldBackgroundColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Color? defaultSendButtonColor;
  final Widget? sendButtonIcon;
  final Color? replyDialogColor;
  final Color? replyTitleColor;
  final Color? replyMessageColor;
  final Color? closeIconColor;

  SendMessageConfiguration({
    this.textFieldBackgroundColor,
    this.hintText,
    this.hintStyle,
    this.defaultSendButtonColor,
    this.sendButtonIcon,
    this.replyDialogColor,
    this.replyTitleColor,
    this.replyMessageColor,
    this.closeIconColor,
    this.textStyle,
  });
}
