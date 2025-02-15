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
  final Color? cameraIconColor;
  final Color? galleryIconColor;
  final Color? recordIconColor;
  final Color? stopIconColor;
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
  final Color? waveformBackgroundColor;
  final Color? waveColor;
  final Color? replyMicIconColor;
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
    this.cameraIconColor,
    this.galleryIconColor,
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
    this.recordIconColor,
    this.stopIconColor,
    this.waveformBackgroundColor,
    this.waveColor,
    this.replyMicIconColor,
  });
}

class DarkTheme extends AppTheme {
  DarkTheme({
    Color super.flashingCircleDarkColor = Colors.grey,
    Color super.flashingCircleBrightColor = const Color(0xffeeeeee),
    TextStyle super.incomingChatLinkTitleStyle = const TextStyle(color: Colors.black),
    TextStyle super.outgoingChatLinkTitleStyle = const TextStyle(color: Colors.white),
    TextStyle super.outgoingChatLinkBodyStyle = const TextStyle(color: Colors.white),
    TextStyle super.incomingChatLinkBodyStyle = const TextStyle(color: Colors.white),
    double super.elevation = 1,
    Color super.repliedTitleTextColor = Colors.white,
    super.swipeToReplyIconColor = Colors.white,
    Color super.textFieldTextColor = Colors.white,
    Color super.appBarColor = const Color(0xff1d1b25),
    Color super.backArrowColor = Colors.white,
    Color super.backgroundColor = const Color(0xff272336),
    Color super.replyDialogColor = const Color(0xff272336),
    Color super.linkPreviewOutgoingChatColor = const Color(0xff272336),
    Color super.linkPreviewIncomingChatColor = const Color(0xff9f85ff),
    TextStyle super.linkPreviewIncomingTitleStyle = const TextStyle(),
    TextStyle super.linkPreviewOutgoingTitleStyle = const TextStyle(),
    Color super.replyTitleColor = Colors.white,
    Color super.textFieldBackgroundColor = const Color(0xff383152),
    Color super.outgoingChatBubbleColor = const Color(0xff9f85ff),
    Color super.inComingChatBubbleColor = const Color(0xff383152),
    Color super.reactionPopupColor = const Color(0xff383152),
    Color super.replyPopupColor = const Color(0xff383152),
    Color super.replyPopupButtonColor = Colors.white,
    Color super.replyPopupTopBorderColor = Colors.black54,
    Color super.reactionPopupTitleColor = Colors.white,
    Color super.inComingChatBubbleTextColor = Colors.white,
    Color super.repliedMessageColor = const Color(0xff9f85ff),
    Color super.closeIconColor = Colors.white,
    Color super.shareIconBackgroundColor = const Color(0xff383152),
    Color super.sendButtonColor = Colors.white,
    Color super.cameraIconColor = const Color(0xff757575),
    Color super.galleryIconColor = const Color(0xff757575),
    Color recorderIconColor = const Color(0xff757575),
    Color super.stopIconColor = const Color(0xff757575),
    Color super.replyMessageColor = Colors.grey,
    Color super.appBarTitleTextStyle = Colors.white,
    Color super.messageReactionBackGroundColor = const Color(0xff383152),
    Color super.messageReactionBorderColor = const Color(0xff272336),
    Color super.verticalBarColor = const Color(0xff383152),
    Color super.chatHeaderColor = Colors.white,
    Color super.themeIconColor = Colors.white,
    Color super.shareIconColor = Colors.white,
    Color super.messageTimeIconColor = Colors.white,
    Color super.messageTimeTextColor = Colors.white,
    Color super.waveformBackgroundColor = const Color(0xff383152),
    Color super.waveColor = Colors.white,
    Color super.replyMicIconColor = Colors.white,
  }) : super(
          recordIconColor: recorderIconColor,
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
    Color cameraIconColor = Colors.black,
    Color galleryIconColor = Colors.black,
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
    Color recorderIconColor = Colors.black,
    Color stopIconColor = Colors.black,
    Color waveformBackgroundColor = Colors.white,
    Color waveColor = Colors.black,
    Color replyMicIconColor = Colors.black,
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
          galleryIconColor: galleryIconColor,
          cameraIconColor: cameraIconColor,
          stopIconColor: stopIconColor,
          recordIconColor: recorderIconColor,
          waveformBackgroundColor: waveformBackgroundColor,
          waveColor: waveColor,
          replyMicIconColor: replyMicIconColor,
        );
}
