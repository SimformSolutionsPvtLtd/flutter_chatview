import 'package:flutter/material.dart';

class RepliedMsgAutoScrollConfig {
  /// Auto scrolls to original message when tapped on replied message.
  /// Defaults to true.
  final bool enableScrollToRepliedMsg;

  /// Highlights the text by changing background color of chat bubble for
  /// given duration. Default to true.
  final bool enableHighlightRepliedMsg;

  /// Chat bubble color when highlighted. Defaults to Colors.grey.
  final Color highlightColor;

  /// Chat will remain highlighted for this duration. Defaults to 500ms.
  final Duration highlightDuration;

  /// When replied message have image or only emojis. They will be scaled
  /// for provided [highlightDuration] to highlight them. Defaults to 1.1
  final double highlightScale;

  /// Time taken to auto scroll to original message. Default to 300ms.
  final Duration highlightScrollDuration;

  /// Animation curve for auto scroll. Defaults to Curves.easeIn.
  final Curve highlightScrollCurve;

  final bool isJumpTo;

  /// * 0 aligns the top edge of the item with the top edge of the view.
  /// * 1 aligns the top edge of the item with the bottom of the view.
  /// * 0.5 aligns the top edge of the item with the center of the view.
  final double? alignment;

  /// Configuration for auto scrolling and highlighting a message when
  /// tapping on the original message above the replied message.
  const RepliedMsgAutoScrollConfig({
    this.enableHighlightRepliedMsg = true,
    this.enableScrollToRepliedMsg = true,
    this.highlightColor = Colors.grey,
    this.highlightDuration = const Duration(milliseconds: 500),
    this.highlightScale = 1.1,
    this.alignment,
    this.isJumpTo = true,
    this.highlightScrollDuration = const Duration(milliseconds: 300),
    this.highlightScrollCurve = Curves.easeIn,
  });
}
