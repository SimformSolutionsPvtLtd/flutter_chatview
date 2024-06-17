import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

/// A configuration model class for voice message bubble.
class VoiceMessageConfiguration {
  const VoiceMessageConfiguration({
    this.playerWaveStyle = const PlayerWaveStyle(scaleFactor: 70),
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.margin,
    this.decoration,
    this.animationCurve = Curves.easeIn,
    this.animationDuration = const Duration(milliseconds: 500),
    this.playIcon,
    this.playIconColor,
    this.pauseIcon,
    this.pauseIconColor,
    this.waveformMargin,
    this.waveformPadding = const EdgeInsets.only(right: 10),
    this.enableSeekGesture = true,
  });

  /// Applies style to waveform.
  final PlayerWaveStyle playerWaveStyle;

  /// Applies padding to message bubble.
  final EdgeInsets padding;

  /// Applies margin to message bubble.
  final EdgeInsets? margin;

  /// Applies padding to waveform.
  final EdgeInsets waveformPadding;

  /// Applies padding to waveform.
  final EdgeInsets? waveformMargin;

  /// BoxDecoration for voice message bubble.
  final BoxDecoration? decoration;

  /// Duration for grow animation for waveform. Default to 500 ms.
  final Duration animationDuration;

  /// Curve for for grow animation for waveform. Default to Curve.easeIn.
  final Curve animationCurve;

  /// Icon for playing the audio.
  final Icon? playIcon;

  /// Color for the playIcon if it is not overridden
  final Color? playIconColor;

  /// Icon for pausing audio
  final Icon? pauseIcon;

  /// Color for the pauseIcon if it is not overridden
  final Color? pauseIconColor;

  /// Enable/disable seeking with gestures. Enabled by default.
  final bool enableSeekGesture;
}
