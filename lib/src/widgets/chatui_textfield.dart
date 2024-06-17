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
import 'dart:async';
import 'dart:io' show File, Platform;

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:chatview/src/utils/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../chatview.dart';
import '../utils/debounce.dart';
import '../utils/package_strings.dart';

class ChatUITextField extends StatefulWidget {
  const ChatUITextField({
    Key? key,
    required this.sendMessageConfig,
    required this.enabled,
    required this.focusNode,
    required this.textEditingController,
    required this.onPressed,
    required this.onRecordingComplete,
    required this.onImageSelected,
  }) : super(key: key);

  /// To enable or disable sending action.
  final bool enabled;

  /// Provides configuration of default text field in chat.
  final SendMessageConfiguration sendMessageConfig;

  /// Provides focusNode for focusing text field.
  final FocusNode focusNode;

  /// Provides functions which handles text field.
  final TextEditingController textEditingController;

  /// Provides callback when user tap on text field.
  final VoidCallBack onPressed;

  /// Provides callback once voice is recorded.
  final Function(String?) onRecordingComplete;

  /// Provides callback when user select images from camera/gallery.
  final StringsCallBack onImageSelected;

  @override
  State<ChatUITextField> createState() => _ChatUITextFieldState();
}

class _ChatUITextFieldState extends State<ChatUITextField> {
  final ValueNotifier<String> _inputText = ValueNotifier('');

  final ImagePicker _imagePicker = ImagePicker();

  RecorderController? controller;

  ValueNotifier<bool> isRecording = ValueNotifier(false);

  SendMessageConfiguration get sendMessageConfig => widget.sendMessageConfig;

  VoiceRecordingConfiguration? get voiceRecordingConfig =>
      widget.sendMessageConfig.voiceRecordingConfiguration;

  ImagePickerIconsConfiguration? get imagePickerIconsConfig =>
      sendMessageConfig.imagePickerIconsConfig;

  TextFieldConfiguration get textFieldConfig =>
      sendMessageConfig.textFieldConfig;

  CancelRecordConfiguration? get cancelRecordConfiguration =>
      sendMessageConfig.cancelRecordConfiguration;

  OutlineInputBorder get _outlineBorder => OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: widget.sendMessageConfig.textFieldConfig.borderRadius ??
            BorderRadius.circular(textFieldBorderRadius),
      );

  ValueNotifier<TypeWriterStatus> composingStatus =
      ValueNotifier(TypeWriterStatus.typed);

  late Debouncer debouncer;

  @override
  void initState() {
    attachListeners();
    debouncer =
        Debouncer(sendMessageConfig.textFieldConfig.compositionThresholdTime);
    super.initState();

    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      controller = RecorderController();
    }
  }

  @override
  void dispose() {
    debouncer.dispose();
    composingStatus.dispose();
    isRecording.dispose();
    _inputText.dispose();
    super.dispose();
  }

  void attachListeners() {
    composingStatus.addListener(() {
      widget.sendMessageConfig.textFieldConfig.onMessageTyping
          ?.call(composingStatus.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = _outlineBorder;
    return ClipRRect(
      borderRadius: textFieldConfig.borderRadius ??
          BorderRadius.circular(textFieldBorderRadius),
      child: Container(
        padding: textFieldConfig.padding ??
            const EdgeInsets.symmetric(horizontal: 6),
        margin: textFieldConfig.margin,
        decoration: BoxDecoration(
          border: textFieldConfig.border,
          borderRadius: textFieldConfig.borderRadius ??
              BorderRadius.circular(textFieldBorderRadius),
          color: sendMessageConfig.textFieldBackgroundColor,
        ),
        child: ValueListenableBuilder<bool>(
          valueListenable: isRecording,
          builder: (_, isRecordingValue, child) {
            return Row(
              children: [
                if (isRecordingValue && controller != null && !kIsWeb)
                  AudioWaveforms(
                    size: Size(
                        MediaQuery.of(context).size.width *
                            (cancelRecordConfiguration == null ? 0.75 : 0.65),
                        50),
                    recorderController: controller!,
                    margin: voiceRecordingConfig?.margin,
                    padding: voiceRecordingConfig?.padding ??
                        EdgeInsets.symmetric(
                          horizontal: cancelRecordConfiguration == null ? 8 : 5,
                        ),
                    decoration: voiceRecordingConfig?.decoration ??
                        BoxDecoration(
                          color: voiceRecordingConfig?.backgroundColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                    waveStyle: voiceRecordingConfig?.waveStyle ??
                        WaveStyle(
                          extendWaveform: true,
                          showMiddleLine: false,
                          waveColor:
                              voiceRecordingConfig?.waveStyle?.waveColor ??
                                  Colors.black,
                        ),
                  )
                else
                  Expanded(
                    child: TextField(
                      focusNode: widget.focusNode,
                      controller: widget.textEditingController,
                      style: textFieldConfig.textStyle ??
                          const TextStyle(color: Colors.white),
                      maxLines: textFieldConfig.maxLines ?? 5,
                      minLines: textFieldConfig.minLines ?? 1,
                      keyboardType: textFieldConfig.textInputType,
                      inputFormatters: textFieldConfig.inputFormatters,
                      onChanged: _onChanged,
                      enabled: textFieldConfig.enabled,
                      textCapitalization: textFieldConfig.textCapitalization ??
                          TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText:
                            textFieldConfig.hintText ?? PackageStrings.message,
                        fillColor: sendMessageConfig.textFieldBackgroundColor,
                        filled: true,
                        hintStyle: textFieldConfig.hintStyle ??
                            TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                              letterSpacing: 0.25,
                            ),
                        contentPadding: textFieldConfig.contentPadding ??
                            const EdgeInsets.symmetric(horizontal: 6),
                        border: outlineBorder,
                        focusedBorder: outlineBorder,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: textFieldConfig.borderRadius ??
                              BorderRadius.circular(textFieldBorderRadius),
                        ),
                        disabledBorder: outlineBorder,
                      ),
                    ),
                  ),
                ValueListenableBuilder<String>(
                  valueListenable: _inputText,
                  builder: (_, inputTextValue, child) {
                    if (inputTextValue.isNotEmpty && widget.enabled) {
                      return IconButton(
                        color: sendMessageConfig.defaultSendButtonColor ??
                            Colors.green,
                        onPressed: (textFieldConfig.enabled)
                            ? () {
                                widget.onPressed();
                                _inputText.value = '';
                              }
                            : null,
                        icon: sendMessageConfig.sendButtonIcon ??
                            const Icon(Icons.send),
                      );
                    } else {
                      return Row(
                        children: [
                          if (!isRecordingValue &&
                              widget.sendMessageConfig.allowImageSending) ...[
                            if (sendMessageConfig.enableCameraImagePicker)
                              IconButton(
                                constraints: const BoxConstraints(),
                                onPressed: (textFieldConfig.enabled)
                                    ? () => _onIconPressed(
                                          ImageSource.camera,
                                          config: sendMessageConfig
                                              .imagePickerConfiguration,
                                        )
                                    : null,
                                icon: imagePickerIconsConfig
                                        ?.cameraImagePickerIcon ??
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: imagePickerIconsConfig
                                          ?.cameraIconColor,
                                    ),
                              ),
                            if (sendMessageConfig.enableGalleryImagePicker)
                              IconButton(
                                constraints: const BoxConstraints(),
                                onPressed: (textFieldConfig.enabled)
                                    ? () => _onIconPressed(
                                          ImageSource.gallery,
                                          config: sendMessageConfig
                                              .imagePickerConfiguration,
                                        )
                                    : null,
                                icon: imagePickerIconsConfig
                                        ?.galleryImagePickerIcon ??
                                    Icon(
                                      Icons.image,
                                      color: imagePickerIconsConfig
                                          ?.galleryIconColor,
                                    ),
                              ),
                          ],
                          if (widget.sendMessageConfig.allowRecordingVoice &&
                              !kIsWeb &&
                              (Platform.isIOS || Platform.isAndroid))
                            IconButton(
                              onPressed: (textFieldConfig.enabled)
                                  ? _recordOrStop
                                  : null,
                              icon: (isRecordingValue
                                      ? voiceRecordingConfig?.micIcon
                                      : voiceRecordingConfig?.stopIcon) ??
                                  Icon(
                                    isRecordingValue ? Icons.stop : Icons.mic,
                                    color:
                                        voiceRecordingConfig?.recorderIconColor,
                                  ),
                            ),
                          if (isRecordingValue &&
                              cancelRecordConfiguration != null)
                            IconButton(
                              onPressed: () {
                                cancelRecordConfiguration?.onCancel?.call();
                                _cancelRecording();
                              },
                              icon: cancelRecordConfiguration?.icon ??
                                  const Icon(Icons.cancel_outlined),
                              color: cancelRecordConfiguration?.iconColor ??
                                  voiceRecordingConfig?.recorderIconColor,
                            ),
                        ],
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  FutureOr<void> _cancelRecording() async {
    assert(
      defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android,
      "Voice messages are only supported with android and ios platform",
    );
    if (!isRecording.value) return;
    final path = await controller?.stop();
    if (path == null) {
      isRecording.value = false;
      return;
    }
    final file = File(path);

    if (await file.exists()) {
      await file.delete();
    }

    isRecording.value = false;
  }

  Future<void> _recordOrStop() async {
    assert(
      defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android,
      "Voice messages are only supported with android and ios platform",
    );
    if (!isRecording.value) {
      await controller?.record(
        sampleRate: voiceRecordingConfig?.sampleRate,
        bitRate: voiceRecordingConfig?.bitRate,
        androidEncoder: voiceRecordingConfig?.androidEncoder,
        iosEncoder: voiceRecordingConfig?.iosEncoder,
        androidOutputFormat: voiceRecordingConfig?.androidOutputFormat,
      );
      isRecording.value = true;
    } else {
      final path = await controller?.stop();
      isRecording.value = false;
      widget.onRecordingComplete(path);
    }
  }

  void _onIconPressed(
    ImageSource imageSource, {
    ImagePickerConfiguration? config,
  }) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: imageSource,
        maxHeight: config?.maxHeight,
        maxWidth: config?.maxWidth,
        imageQuality: config?.imageQuality,
        preferredCameraDevice:
            config?.preferredCameraDevice ?? CameraDevice.rear,
      );
      String? imagePath = image?.path;
      if (config?.onImagePicked != null) {
        String? updatedImagePath = await config?.onImagePicked!(imagePath);
        if (updatedImagePath != null) imagePath = updatedImagePath;
      }
      widget.onImageSelected(imagePath ?? '', '');
    } catch (e) {
      widget.onImageSelected('', e.toString());
    }
  }

  void _onChanged(String inputText) {
    debouncer.run(() {
      composingStatus.value = TypeWriterStatus.typed;
    }, () {
      composingStatus.value = TypeWriterStatus.typing;
    });
    _inputText.value = inputText;
  }
}
