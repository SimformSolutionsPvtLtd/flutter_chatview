/*
 * Copyright (c) 2022 Simform Solutions
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendMessageConfiguration {
  final Color? textFieldBackgroundColor;

  final Color? defaultSendButtonColor;
  final Widget? sendButtonIcon;
  final Color? replyDialogColor;
  final Color? replyTitleColor;
  final Color? replyMessageColor;
  final Color? closeIconColor;
  final ImagePickerIconsConfiguration? imagePickerIconsConfig;
  final TextFieldConfiguration? textFieldConfig;

  /// Enable/disable voice recording. Enabled by default.
  final bool allowRecordingVoice;

  /// Color of mic icon when replying to some voice message.
  final Color? micIconColor;

  /// Styling configuration for recorder widget.
  final VoiceRecordingConfiguration? voiceRecordingConfiguration;

  SendMessageConfiguration({
    this.textFieldConfig,
    this.textFieldBackgroundColor,
    this.imagePickerIconsConfig,
    this.defaultSendButtonColor,
    this.sendButtonIcon,
    this.replyDialogColor,
    this.replyTitleColor,
    this.replyMessageColor,
    this.closeIconColor,
    this.allowRecordingVoice = true,
    this.voiceRecordingConfiguration,
    this.micIconColor,
  });
}

class ImagePickerIconsConfiguration {
  final Widget? galleryImagePickerIcon;
  final Widget? cameraImagePickerIcon;
  final Color? cameraIconColor;
  final Color? galleryIconColor;

  ImagePickerIconsConfiguration({
    this.cameraIconColor,
    this.galleryIconColor,
    this.galleryImagePickerIcon,
    this.cameraImagePickerIcon,
  });
}

class TextFieldConfiguration {
  final int? maxLines;
  final int? minLines;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  TextCapitalization? textCapitalization;

  TextFieldConfiguration({
    this.contentPadding,
    this.maxLines,
    this.borderRadius,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.padding,
    this.margin,
    this.minLines,
    this.textInputType,
    this.inputFormatters,
    this.textCapitalization,
  });
}

/// Styling configuration for recorder widget.
class VoiceRecordingConfiguration {
  const VoiceRecordingConfiguration({
    this.waveStyle,
    this.padding,
    this.margin,
    this.decoration,
    this.backgroundColor,
    this.micIcon,
    this.recorderIconColor,
    this.stopIcon,
  });

  /// Applies styles to waveform.
  final WaveStyle? waveStyle;

  /// Applies padding around waveform widget.
  final EdgeInsets? padding;

  /// Applies margin around waveform widget.
  final EdgeInsets? margin;

  /// Box decoration containing waveforms
  final BoxDecoration? decoration;

  /// If only background color needs to be changed then use this instead of
  /// decoration.
  final Color? backgroundColor;

  /// An icon for recording voice.
  final Widget? micIcon;

  /// An icon for stopping voice recording.
  final Widget? stopIcon;

  /// Applies color to mic and stop icon.
  final Color? recorderIconColor;
}
