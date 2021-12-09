import 'package:flutter/material.dart';

class AppTheme {
  final Color? appBarColor;
  final Color? backArrowColor;
  final Color? backgroundColor;
  final Color? replyDialogColor;
  final Color? replyTitleColor;
  final Color? textFieldBackgroundColor;

  final Color? outgoingChatBubbleColor;

  final Color? inComingChatBubbleColor;

  final Color? inComingChatBubbleTextColor;
  final Color? repliedMessageColor;
  final Color? repliedTitleTextColor;
  final Color? textFieldTextColor;

  final Color? closeIconColor;
  final Color? shareIconBackgroundColor;

  final Color? sendButtonColor;
  final Color? swipeToReplyIconColor;
  final Color? replyMessageColor;
  final Color? appBarTitleTextStyle;
  final Color? messageReactionBackGroundColor;
  final Color? messageTimeIconColor;
  final Color? messageTimeTextColor;
  final Color? reactionPopupColor;
  final Color? replyPopupColor;
  final Color? replyPopupButtonColor;
  final Color? replyPopupTopBorderColor;
  final Color? reactionPopupTitleColor;
  final Color? flashingCircleDarkColor;
  final Color? flashingCircleBrightColor;

  final Color? messageReactionBorderColor;

  final Color? verticalBarColor;
  final Color? chatHeaderColor;
  final Color? themeIconColor;
  final Color? shareIconColor;
  final double? elevation;
  final Color? linkPreviewIncomingChatColor;
  final Color? linkPreviewOutgoingChatColor;
  final TextStyle? linkPreviewIncomingTitleStyle;
  final TextStyle? linkPreviewOutgoingTitleStyle;
  final TextStyle? incomingChatLinkTitleStyle;
  final TextStyle? outgoingChatLinkTitleStyle;
  final TextStyle? outgoingChatLinkBodyStyle;
  final TextStyle? incomingChatLinkBodyStyle;

  AppTheme({
    this.flashingCircleDarkColor,
    this.flashingCircleBrightColor,
    this.outgoingChatLinkBodyStyle,
    this.incomingChatLinkBodyStyle,
    this.incomingChatLinkTitleStyle,
    this.outgoingChatLinkTitleStyle,
    this.linkPreviewOutgoingChatColor,
    this.linkPreviewIncomingChatColor,
    this.linkPreviewIncomingTitleStyle,
    this.linkPreviewOutgoingTitleStyle,
    this.repliedTitleTextColor,
    this.swipeToReplyIconColor,
    this.textFieldTextColor,
    this.reactionPopupColor,
    this.replyPopupButtonColor,
    this.replyPopupTopBorderColor,
    this.reactionPopupTitleColor,
    this.appBarColor,
    this.backArrowColor,
    this.backgroundColor,
    this.replyDialogColor,
    this.replyTitleColor,
    this.textFieldBackgroundColor,
    this.outgoingChatBubbleColor,
    this.inComingChatBubbleColor,
    this.inComingChatBubbleTextColor,
    this.repliedMessageColor,
    this.closeIconColor,
    this.shareIconBackgroundColor,
    this.sendButtonColor,
    this.replyMessageColor,
    this.appBarTitleTextStyle,
    this.messageReactionBackGroundColor,
    this.messageReactionBorderColor,
    this.verticalBarColor,
    this.chatHeaderColor,
    this.themeIconColor,
    this.shareIconColor,
    this.elevation,
    this.messageTimeIconColor,
    this.messageTimeTextColor,
    this.replyPopupColor,
  });
}

class DarkTheme extends AppTheme {
  DarkTheme({
    Color flashingCircleDarkColor = Colors.grey,
    Color flashingCircleBrightColor = const Color(0xffeeeeee),
    TextStyle incomingChatLinkTitleStyle = const TextStyle(color: Colors.black),
    TextStyle outgoingChatLinkTitleStyle = const TextStyle(color: Colors.white),
    TextStyle outgoingChatLinkBodyStyle = const TextStyle(color: Colors.white),
    TextStyle incomingChatLinkBodyStyle = const TextStyle(color: Colors.white),
    double elevation = 1,
    Color repliedTitleTextColor = Colors.white,
    Color? swipeToReplyIconColor = Colors.white,
    Color textFieldTextColor = Colors.white,
    Color appBarColor = const Color(0xff1d1b25),
    Color backArrowColor = Colors.white,
    Color backgroundColor = const Color(0xff272336),
    Color replyDialogColor = const Color(0xff272336),
    Color linkPreviewOutgoingChatColor = const Color(0xff272336),
    Color linkPreviewIncomingChatColor = const Color(0xff9f85ff),
    TextStyle linkPreviewIncomingTitleStyle = const TextStyle(),
    TextStyle linkPreviewOutgoingTitleStyle = const TextStyle(),
    Color replyTitleColor = Colors.white,
    Color textFieldBackgroundColor = const Color(0xff383152),
    Color outgoingChatBubbleColor = const Color(0xff9f85ff),
    Color inComingChatBubbleColor = const Color(0xff383152),
    Color reactionPopupColor = const Color(0xff383152),
    Color replyPopupColor = const Color(0xff383152),
    Color replyPopupButtonColor = Colors.white,
    Color replyPopupTopBorderColor = Colors.black54,
    Color reactionPopupTitleColor = Colors.white,
    Color inComingChatBubbleTextColor = Colors.white,
    Color repliedMessageColor = const Color(0xff9f85ff),
    Color closeIconColor = Colors.white,
    Color shareIconBackgroundColor = const Color(0xff383152),
    Color sendButtonColor = Colors.white,
    Color replyMessageColor = Colors.grey,
    Color appBarTitleTextStyle = Colors.white,
    Color messageReactionBackGroundColor = const Color(0xff383152),
    Color messageReactionBorderColor = const Color(0xff272336),
    Color verticalBarColor = const Color(0xff383152),
    Color chatHeaderColor = Colors.white,
    Color themeIconColor = Colors.white,
    Color shareIconColor = Colors.white,
    Color messageTimeIconColor = Colors.white,
    Color messageTimeTextColor = Colors.white,
  }) : super(
          closeIconColor: closeIconColor,
          verticalBarColor: verticalBarColor,
          textFieldBackgroundColor: textFieldBackgroundColor,
          replyTitleColor: replyTitleColor,
          replyDialogColor: replyDialogColor,
          backgroundColor: backgroundColor,
          appBarColor: appBarColor,
          appBarTitleTextStyle: appBarTitleTextStyle,
          backArrowColor: backArrowColor,
          chatHeaderColor: chatHeaderColor,
          inComingChatBubbleColor: inComingChatBubbleColor,
          inComingChatBubbleTextColor: inComingChatBubbleTextColor,
          messageReactionBackGroundColor: messageReactionBackGroundColor,
          messageReactionBorderColor: messageReactionBorderColor,
          outgoingChatBubbleColor: outgoingChatBubbleColor,
          repliedMessageColor: repliedMessageColor,
          replyMessageColor: replyMessageColor,
          sendButtonColor: sendButtonColor,
          shareIconBackgroundColor: shareIconBackgroundColor,
          themeIconColor: themeIconColor,
          shareIconColor: shareIconColor,
          elevation: elevation,
          messageTimeIconColor: messageTimeIconColor,
          messageTimeTextColor: messageTimeTextColor,
          textFieldTextColor: textFieldTextColor,
          repliedTitleTextColor: repliedTitleTextColor,
          swipeToReplyIconColor: swipeToReplyIconColor,
          reactionPopupColor: reactionPopupColor,
          replyPopupColor: replyPopupColor,
          replyPopupButtonColor: replyPopupButtonColor,
          replyPopupTopBorderColor: replyPopupTopBorderColor,
          reactionPopupTitleColor: reactionPopupTitleColor,
          linkPreviewOutgoingChatColor: linkPreviewOutgoingChatColor,
          linkPreviewIncomingChatColor: linkPreviewIncomingChatColor,
          linkPreviewIncomingTitleStyle: linkPreviewIncomingTitleStyle,
          linkPreviewOutgoingTitleStyle: linkPreviewOutgoingTitleStyle,
          incomingChatLinkBodyStyle: incomingChatLinkBodyStyle,
          incomingChatLinkTitleStyle: incomingChatLinkTitleStyle,
          outgoingChatLinkBodyStyle: outgoingChatLinkBodyStyle,
          outgoingChatLinkTitleStyle: outgoingChatLinkTitleStyle,
          flashingCircleDarkColor: flashingCircleDarkColor,
          flashingCircleBrightColor: flashingCircleBrightColor,
        );
}

class LightTheme extends AppTheme {
  LightTheme({
    Color flashingCircleDarkColor = const Color(0xffEE5366),
    Color flashingCircleBrightColor = const Color(0xffFCD8DC),
    TextStyle incomingChatLinkTitleStyle = const TextStyle(color: Colors.black),
    TextStyle outgoingChatLinkTitleStyle = const TextStyle(color: Colors.black),
    TextStyle outgoingChatLinkBodyStyle = const TextStyle(color: Colors.grey),
    TextStyle incomingChatLinkBodyStyle = const TextStyle(color: Colors.grey),
    Color textFieldTextColor = Colors.black,
    Color repliedTitleTextColor = Colors.black,
    Color swipeToReplyIconColor = Colors.black,
    double elevation = 2,
    Color appBarColor = Colors.white,
    Color backArrowColor = const Color(0xffEE5366),
    Color backgroundColor = const Color(0xffeeeeee),
    Color replyDialogColor = const Color(0xffFCD8DC),
    Color linkPreviewOutgoingChatColor = const Color(0xffFCD8DC),
    Color linkPreviewIncomingChatColor = const Color(0xFFEEEEEE),
    TextStyle linkPreviewIncomingTitleStyle = const TextStyle(),
    TextStyle linkPreviewOutgoingTitleStyle = const TextStyle(),
    Color replyTitleColor = const Color(0xffEE5366),
    Color reactionPopupColor = Colors.white,
    Color replyPopupColor = Colors.white,
    Color replyPopupButtonColor = Colors.black,
    Color replyPopupTopBorderColor = const Color(0xFFBDBDBD),
    Color reactionPopupTitleColor = Colors.grey,
    Color textFieldBackgroundColor = Colors.white,
    Color outgoingChatBubbleColor = const Color(0xffEE5366),
    Color inComingChatBubbleColor = Colors.white,
    Color inComingChatBubbleTextColor = Colors.black,
    Color repliedMessageColor = const Color(0xffff8aad),
    Color closeIconColor = Colors.black,
    Color shareIconBackgroundColor = const Color(0xFFE0E0E0),
    Color sendButtonColor = const Color(0xffEE5366),
    Color replyMessageColor = Colors.black,
    Color appBarTitleTextStyle = Colors.black,
    Color messageReactionBackGroundColor = const Color(0xFFEEEEEE),
    Color messageReactionBorderColor = Colors.white,
    Color verticalBarColor = const Color(0xffEE5366),
    Color chatHeaderColor = Colors.black,
    Color themeIconColor = Colors.black,
    Color shareIconColor = Colors.black,
    Color messageTimeIconColor = Colors.black,
    Color messageTimeTextColor = Colors.black,
  }) : super(
          reactionPopupColor: reactionPopupColor,
          closeIconColor: closeIconColor,
          verticalBarColor: verticalBarColor,
          textFieldBackgroundColor: textFieldBackgroundColor,
          replyTitleColor: replyTitleColor,
          replyDialogColor: replyDialogColor,
          backgroundColor: backgroundColor,
          appBarColor: appBarColor,
          appBarTitleTextStyle: appBarTitleTextStyle,
          backArrowColor: backArrowColor,
          chatHeaderColor: chatHeaderColor,
          inComingChatBubbleColor: inComingChatBubbleColor,
          inComingChatBubbleTextColor: inComingChatBubbleTextColor,
          messageReactionBackGroundColor: messageReactionBackGroundColor,
          messageReactionBorderColor: messageReactionBorderColor,
          outgoingChatBubbleColor: outgoingChatBubbleColor,
          repliedMessageColor: repliedMessageColor,
          replyMessageColor: replyMessageColor,
          sendButtonColor: sendButtonColor,
          shareIconBackgroundColor: shareIconBackgroundColor,
          themeIconColor: themeIconColor,
          shareIconColor: shareIconColor,
          elevation: elevation,
          messageTimeIconColor: messageTimeIconColor,
          messageTimeTextColor: messageTimeTextColor,
          textFieldTextColor: textFieldTextColor,
          repliedTitleTextColor: repliedTitleTextColor,
          swipeToReplyIconColor: swipeToReplyIconColor,
          replyPopupColor: replyPopupColor,
          replyPopupButtonColor: replyPopupButtonColor,
          replyPopupTopBorderColor: replyPopupTopBorderColor,
          reactionPopupTitleColor: reactionPopupTitleColor,
          linkPreviewOutgoingChatColor: linkPreviewOutgoingChatColor,
          linkPreviewIncomingChatColor: linkPreviewIncomingChatColor,
          linkPreviewIncomingTitleStyle: linkPreviewIncomingTitleStyle,
          linkPreviewOutgoingTitleStyle: linkPreviewOutgoingTitleStyle,
          incomingChatLinkBodyStyle: incomingChatLinkBodyStyle,
          incomingChatLinkTitleStyle: incomingChatLinkTitleStyle,
          outgoingChatLinkBodyStyle: outgoingChatLinkBodyStyle,
          outgoingChatLinkTitleStyle: outgoingChatLinkTitleStyle,
          flashingCircleDarkColor: flashingCircleDarkColor,
          flashingCircleBrightColor: flashingCircleBrightColor,
        );
}
