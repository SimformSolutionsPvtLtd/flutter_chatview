import 'package:chatview/src/values/typedefs.dart';
import 'package:flutter/material.dart';

class ChatViewStateConfiguration {
  const ChatViewStateConfiguration({
    this.errorWidgetConfig = const ChatViewStateWidgetConfiguration(),
    this.noMessageWidgetConfig = const ChatViewStateWidgetConfiguration(),
    this.loadingWidgetConfig = const ChatViewStateWidgetConfiguration(),
    this.onReloadButtonTap,
  });

  final ChatViewStateWidgetConfiguration? errorWidgetConfig;
  final ChatViewStateWidgetConfiguration? noMessageWidgetConfig;
  final ChatViewStateWidgetConfiguration? loadingWidgetConfig;
  final VoidCallBack? onReloadButtonTap;
}

class ChatViewStateWidgetConfiguration {
  const ChatViewStateWidgetConfiguration({
    this.widget,
    this.title,
    this.titleTextStyle,
    this.imageWidget,
    this.subTitle,
    this.subTitleTextStyle,
    this.loadingIndicatorColor,
    this.reloadButton,
    this.showDefaultReloadButton = true,
    this.reloadButtonColor,
  });

  final String? title;
  final String? subTitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final Widget? imageWidget;
  final Color? loadingIndicatorColor;
  final Widget? reloadButton;
  final bool showDefaultReloadButton;
  final Color? reloadButtonColor;
  final Widget? widget;
}
