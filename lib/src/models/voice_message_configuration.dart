import 'package:flutter/material.dart';

/// A configuration model class for voice message bubble.
class VoiceMessageConfiguration {
  const VoiceMessageConfiguration({
    this.backgroundColor = Colors.white,
    this.activeSliderColor = Colors.red,
    this.notActiveSliderColor,
    this.circlesColor = Colors.red,
    this.innerPadding = 10,
    this.cornerRadius = 16,
    this.size = 38,
    this.circlesTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),
    this.counterTextStyle = const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
    ),
  });

  /// The background color of the voice message view.
  final Color backgroundColor;

  ///
  final Color circlesColor;

  /// The color of the active slider.
  final Color activeSliderColor;

  /// The color of the not active slider.
  final Color? notActiveSliderColor;

  /// The text style of the circles.
  final TextStyle circlesTextStyle;

  /// The text style of the counter.
  final TextStyle counterTextStyle;

  /// The padding between the inner content and the outer container.
  final double innerPadding;

  /// The corner radius of the outer container.
  final double cornerRadius;

  /// The size of the play/pause button.
  final double size;
}
