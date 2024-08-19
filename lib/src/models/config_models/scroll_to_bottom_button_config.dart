import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';

/// Configuration for the "Scroll to Bottom" button.
class ScrollToBottomButtonConfig {
  ScrollToBottomButtonConfig({
    this.backgroundColor,
    this.border,
    this.borderRadius,
    this.icon,
    this.scrollAnimationDuration,
    this.alignment,
    this.padding,
    this.onClick,
    this.buttonDisplayOffset,
  });

  /// The background color of the button.
  final Color? backgroundColor;

  /// The border of the button.
  final Border? border;

  /// The border radius of the button.
  final BorderRadius? borderRadius;

  /// The icon displayed on the button.
  final Icon? icon;

  /// The duration of the scroll animation when the button is clicked.
  final Duration? scrollAnimationDuration;

  /// The alignment of the button on top of text field.
  final ScrollButtonAlignment? alignment;

  /// The padding around the button.
  final EdgeInsets? padding;

  /// The callback function to be executed when the button is clicked.
  final VoidCallback? onClick;

  /// The scroll offset after which the button is displayed.
  /// The button appears when the scroll position is greater than or equal to this value.
  final double? buttonDisplayOffset;
}
