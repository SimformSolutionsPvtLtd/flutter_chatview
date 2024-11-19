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
import 'package:image_picker/image_picker.dart';

import '../../values/enumeration.dart';
import '../../values/typedefs.dart';

class SendMessageConfiguration {
  /// Used to give background color to text field.
  final Color? textFieldBackgroundColor;

  /// Used to give color to send button.
  final Color? defaultSendButtonColor;

  /// Provides ability to give custom send button.
  final Widget? sendButtonIcon;

  /// Used to give reply dialog color.
  final Color? replyDialogColor;

  /// Used to give color to title of reply pop-up.
  final Color? replyTitleColor;

  /// Used to give color to reply message.
  final Color? replyMessageColor;

  /// Used to give color to close icon in reply pop-up.
  final Color? closeIconColor;

  /// Provides configuration of image picker functionality.
  final ImagePickerIconsConfiguration? imagePickerIconsConfig;

  /// Provides configuration of image picker plugin.
  final ImagePickerConfiguration? imagePickerConfiguration;

  /// Provides configuration of text field.
  final TextFieldConfiguration? textFieldConfig;

  /// Enable/disable voice recording. Enabled by default.
  final bool allowRecordingVoice;

  /// Enable/disable image picker from gallery. Enabled by default.
  final bool enableGalleryImagePicker;

  /// Enable/disable send image from camera. Enabled by default.
  final bool enableCameraImagePicker;

  /// Color of mic icon when replying to some voice message.
  final Color? micIconColor;

  /// Styling configuration for recorder widget.
  final VoiceRecordingConfiguration? voiceRecordingConfiguration;

  /// Configuration for cancel voice recording
  final CancelRecordConfiguration? cancelRecordConfiguration;

  const SendMessageConfiguration({
    this.textFieldConfig,
    this.textFieldBackgroundColor,
    this.imagePickerIconsConfig,
    this.imagePickerConfiguration,
    this.defaultSendButtonColor,
    this.sendButtonIcon,
    this.replyDialogColor,
    this.replyTitleColor,
    this.replyMessageColor,
    this.closeIconColor,
    this.allowRecordingVoice = true,
    this.enableCameraImagePicker = true,
    this.enableGalleryImagePicker = true,
    this.voiceRecordingConfiguration,
    this.micIconColor,
    this.cancelRecordConfiguration,
  });
}

class ImagePickerIconsConfiguration {
  /// Provides ability to pass custom gallery image picker icon.
  final Widget? galleryImagePickerIcon;

  /// Provides ability to pass custom camera image picker icon.
  final Widget? cameraImagePickerIcon;

  /// Used to give color to camera icon.
  final Color? cameraIconColor;

  /// Used to give color to gallery icon.
  final Color? galleryIconColor;

  const ImagePickerIconsConfiguration({
    this.cameraIconColor,
    this.galleryIconColor,
    this.galleryImagePickerIcon,
    this.cameraImagePickerIcon,
  });
}

class TextFieldConfiguration {
  /// Used to give max lines in text field.
  final int? maxLines;

  /// Used to give min lines in text field.
  final int? minLines;

  /// Used to give padding in text field.
  final EdgeInsetsGeometry? padding;

  /// Used to give margin in text field.
  final EdgeInsetsGeometry? margin;

  /// Used to give hint text in text field.
  final String? hintText;

  /// Used to give text style of hint text in text field.
  final TextStyle? hintStyle;

  /// Used to give text style of actual text in text field.
  final TextStyle? textStyle;

  /// Used to give border radius in text field.
  final BorderRadius? borderRadius;

  /// Used to give content padding in text field.
  final EdgeInsetsGeometry? contentPadding;

  /// Used to give text input type of text field.
  final TextInputType? textInputType;

  /// Used to give list of input formatters for text field.
  final List<TextInputFormatter>? inputFormatters;

  /// Used to give textCapitalization enums to text field.
  final TextCapitalization? textCapitalization;

  /// Callback when a user starts/stops typing a message by [TypeWriterStatus]
  final void Function(TypeWriterStatus status)? onMessageTyping;

  /// After typing stopped, the threshold time after which the composing
  /// status to be changed to [TypeWriterStatus.composed].
  /// Default is 1 second.
  final Duration compositionThresholdTime;

  /// Used for enable or disable the chat text field.
  /// [false] also will disable the buttons for send images, record audio or take picture.
  /// Default is [true].
  final bool enabled;

  /// Determines if pressing enter submits the message.
  /// Defaults to [false].
  final bool enableEnterToSubmit;

  const TextFieldConfiguration({
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
    this.onMessageTyping,
    this.compositionThresholdTime = const Duration(seconds: 1),
    this.inputFormatters,
    this.textCapitalization,
    this.enabled = true,
    this.enableEnterToSubmit = false,
  });
}

class ImagePickerConfiguration {
  /// Used to give max width of image.
  final double? maxWidth;

  /// Used to give max height of image.
  final double? maxHeight;

  /// Used to give image quality.
  final int? imageQuality;

  /// Preferred camera device to pick image from.
  final CameraDevice? preferredCameraDevice;

  /// Callback when image is picked from camera or gallery,
  ///  we can perform our task on image like adding crop options and return new image path
  final Future<String?> Function(String? path)? onImagePicked;

  const ImagePickerConfiguration({
    this.maxWidth,
    this.maxHeight,
    this.imageQuality,
    this.preferredCameraDevice,
    this.onImagePicked,
  });
}

class VoiceRecordingConfiguration {
  /// Styling configuration for the recorder widget as well as
  /// configuring the audio recording quality.
  const VoiceRecordingConfiguration({
    this.waveStyle,
    this.padding,
    this.margin,
    this.decoration,
    this.backgroundColor,
    this.micIcon,
    this.recorderIconColor,
    this.stopIcon,
    this.sampleRate,
    this.bitRate,
    this.androidEncoder,
    this.iosEncoder,
    this.androidOutputFormat,
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

  /// The sample rate for audio is measured in samples per second.
  /// A higher sample rate generates more samples per second,
  /// resulting in better audio quality but also larger file sizes.
  final int? sampleRate;

  /// Bitrate is the amount of data per second that the codec uses to
  /// encode the audio. A higher bitrate results in better quality
  /// but also larger file sizes.
  final int? bitRate;

  /// Audio encoder to be used for recording for IOS.
  final IosEncoder? iosEncoder;

  /// Audio encoder to be used for recording for Android.
  final AndroidEncoder? androidEncoder;

  /// The audio output format to be used for recorded audio files on Android.
  final AndroidOutputFormat? androidOutputFormat;
}

class CancelRecordConfiguration {
  /// Configuration for cancel voice recording
  const CancelRecordConfiguration({
    this.icon,
    this.iconColor,
    this.onCancel,
  });

  /// An icon for cancelling voice recording.
  final Widget? icon;

  /// Cancel record icon color
  final Color? iconColor;

  /// Provides callback on voice record cancel
  final VoidCallBack? onCancel;
}
