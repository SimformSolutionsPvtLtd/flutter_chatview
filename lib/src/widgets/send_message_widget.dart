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
import 'package:chatview/chatview.dart';
import 'package:chatview/src/extensions/extensions.dart';
import 'package:chatview/src/utils/package_strings.dart';
import 'package:chatview/src/widgets/chatui_textfield.dart';
import 'package:chatview/src/widgets/reply_message_view.dart';
import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({
    Key? key,
    required this.onSendTap,
    required this.enabled,
    required this.chatController,
    required this.sendMessageConfig,
    this.backgroundColor,
    this.sendMessageBuilder,
    this.onReplyCallback,
    this.onReplyCloseCallback,
    this.messageConfig,
    this.replyMessageBuilder,
  }) : super(key: key);

  /// To determine if the user can press send or not.
  final bool enabled;

  /// Provides call back when user tap on send button on text field.
  final StringMessageCallBack onSendTap;

  /// Provides configuration for text field appearance.
  final SendMessageConfiguration sendMessageConfig;

  /// Allow user to set background colour.
  final Color? backgroundColor;

  /// Allow user to set custom text field.
  final ReplyMessageWithReturnWidget? sendMessageBuilder;

  /// Provides callback when user swipes chat bubble for reply.
  final ReplyMessageCallBack? onReplyCallback;

  /// Provides call when user tap on close button which is showed in reply pop-up.
  final VoidCallBack? onReplyCloseCallback;

  /// Provides controller for accessing few function for running chat.
  final ChatController chatController;

  /// Provides configuration of all types of messages.
  final MessageConfiguration? messageConfig;

  /// Provides a callback for the view when replying to message
  final CustomViewForReplyMessage? replyMessageBuilder;

  @override
  State<SendMessageWidget> createState() => SendMessageWidgetState();
}

class SendMessageWidgetState extends State<SendMessageWidget> {
  final _textEditingController = TextEditingController();
  final ValueNotifier<ReplyMessage> _replyMessage =
      ValueNotifier(const ReplyMessage());

  ReplyMessage get replyMessage => _replyMessage.value;
  final _focusNode = FocusNode();

  ChatUser? get repliedUser => replyMessage.replyTo.isNotEmpty
      ? widget.chatController.getUserFromId(replyMessage.replyTo)
      : null;

  SendMessageConfiguration get sendMessageConfig => widget.sendMessageConfig;

  TextFieldConfiguration get textFieldConfig =>
      sendMessageConfig.textFieldConfig;

  String get _replyTo => replyMessage.replyTo == currentUser?.id
      ? PackageStrings.you
      : repliedUser?.name ?? '';

  ChatUser? get currentUser => provide?.currentUser;

  @override
  Widget build(BuildContext context) {
    return widget.sendMessageBuilder != null
        ? Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: widget.sendMessageBuilder!(replyMessage),
          )
        : Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ValueListenableBuilder<ReplyMessage>(
                      valueListenable: _replyMessage,
                      builder: (_, state, child) {
                        if (state.message.isNotEmpty) {
                          if (widget.replyMessageBuilder != null) {
                            return widget.replyMessageBuilder!
                                .call(context, state);
                          }

                          return Container(
                            height: 60,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 4,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: textFieldBorderRadius / 2,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: widget.sendMessageConfig.replyDialogColor,
                              borderRadius:
                                  BorderRadius.circular(textFieldBorderRadius),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          _replyTo,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: widget.sendMessageConfig
                                                .replyTitleColor,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.25,
                                          ),
                                        ),
                                      ),
                                      ReplyMessageView(
                                        message: state,
                                        customMessageReplyViewBuilder: widget
                                            .messageConfig
                                            ?.customMessageReplyViewBuilder,
                                        sendMessageConfig:
                                            widget.sendMessageConfig,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.close,
                                    color:
                                        widget.sendMessageConfig.closeIconColor,
                                    size: 16,
                                  ),
                                  onPressed: onCloseTap,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    ChatUITextField(
                      enabled: widget.enabled,
                      focusNode: _focusNode,
                      textEditingController: _textEditingController,
                      onPressed: _onPressed,
                      sendMessageConfig: widget.sendMessageConfig,
                      onRecordingComplete: _onRecordingComplete,
                      onImageSelected: _onImageSelected,
                    )
                  ],
                ),
              ),
            ),
          );
  }

  void _onRecordingComplete(String? path) {
    if (path != null) {
      widget.onSendTap.call(path, replyMessage, MessageType.voice);
      _assignRepliedMessage();
    }
  }

  void _onImageSelected(String imagePath, String error) {
    debugPrint('Call in Send Message Widget');
    if (imagePath.isNotEmpty) {
      widget.onSendTap.call(imagePath, replyMessage, MessageType.image);
      _assignRepliedMessage();
    }
  }

  void _assignRepliedMessage() {
    if (replyMessage.message.isNotEmpty) {
      _replyMessage.value = const ReplyMessage();
    }
  }

  void _onPressed() {
    final messageText = _textEditingController.text.trim();
    _textEditingController.clear();
    if (messageText.isEmpty) return;

    widget.onSendTap.call(
      messageText.trim(),
      replyMessage,
      MessageType.text,
    );
    _assignRepliedMessage();
  }

  void assignReplyMessage(Message message) {
    if (currentUser != null) {
      _replyMessage.value = ReplyMessage(
        message: message.message,
        replyBy: currentUser!.id,
        replyTo: message.sendBy,
        messageType: message.messageType,
        messageId: message.id,
        voiceMessageDuration: message.voiceMessageDuration,
      );
    }
    FocusScope.of(context).requestFocus(_focusNode);
    if (widget.onReplyCallback != null) widget.onReplyCallback!(replyMessage);
  }

  void onCloseTap() {
    _replyMessage.value = const ReplyMessage();
    if (widget.onReplyCloseCallback != null) widget.onReplyCloseCallback!();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    _replyMessage.dispose();
    super.dispose();
  }
}
