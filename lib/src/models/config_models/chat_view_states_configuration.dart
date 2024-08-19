import 'package:chatview/src/values/typedefs.dart';
import 'package:flutter/material.dart';

class ChatViewStateConfiguration {
  const ChatViewStateConfiguration({
    this.errorWidgetConfig = const ChatViewStateWidgetConfiguration(),
    this.noMessageWidgetConfig = const ChatViewStateWidgetConfiguration(),
    this.loadingWidgetConfig = const ChatViewStateWidgetConfiguration(),
    this.onReloadButtonTap,
  });

  /// Provides configuration of error state's widget.
  final ChatViewStateWidgetConfiguration? errorWidgetConfig;

  /// Provides configuration of no message state's widget.
  final ChatViewStateWidgetConfiguration? noMessageWidgetConfig;

  /// Provides configuration of loading state's widget.
  final ChatViewStateWidgetConfiguration? loadingWidgetConfig;

  /// Provides callback when user taps on reload button.
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

  /// Used to give title of state.
  final String? title;

  /// Used to give sub-title of state.
  final String? subTitle;

  /// Used to give text style of title in any state.
  final TextStyle? titleTextStyle;

  /// Used to give text style of sub-title in any state.
  final TextStyle? subTitleTextStyle;

  /// Provides parameter to pass image widget in any state.
  final Widget? imageWidget;

  /// Used to give color of loading indicator.
  final Color? loadingIndicatorColor;

  /// Provides parameter to pass custom reload button in any state.
  final Widget? reloadButton;

  /// Used to show reload button.
  final bool showDefaultReloadButton;

  /// Used to give color of reload button.
  final Color? reloadButtonColor;

  /// Gives ability to pass custom widget in any state.
  final Widget? widget;
}
