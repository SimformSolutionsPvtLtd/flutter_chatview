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
import 'dart:io' if (kIsWeb) 'dart:html';
import 'dart:ui';
import 'package:chatview/src/widgets/chatui_textfield.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:chatview/src/extensions/extensions.dart';
import 'package:chatview/src/utils/package_strings.dart';

import '../utils/constants.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({
    Key? key,
    required this.onSendTap,
    this.sendMessageConfig,
    required this.sender,
    required this.receiver,
    this.backgroundColor,
    this.sendMessageBuilder,
    this.onReplyCallback,
    this.onReplyCloseCallback,
  }) : super(key: key);
  final StringMessageCallBack onSendTap;
  final ChatUser sender;
  final ChatUser receiver;
  final SendMessageConfiguration? sendMessageConfig;
  final Color? backgroundColor;
  final ReplyMessageWithReturnWidget? sendMessageBuilder;
  final ReplyMessageCallBack? onReplyCallback;
  final VoidCallBack? onReplyCloseCallback;

  @override
  State<SendMessageWidget> createState() => SendMessageWidgetState();
}

class SendMessageWidgetState extends State<SendMessageWidget> {
  final _textEditingController = TextEditingController();
  ReplyMessage _replyMessage = ReplyMessage();
  final _focusNode = FocusNode();

  String get _replyTo => _replyMessage.replyTo == widget.sender.id
      ? PackageStrings.you
      : widget.receiver.name;

  @override
  Widget build(BuildContext context) {
    return widget.sendMessageBuilder != null
        ? Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: widget.sendMessageBuilder!(_replyMessage),
          )
        : Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height /
                          ((!kIsWeb && Platform.isIOS) ? 24 : 28),
                      color: widget.backgroundColor ?? Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      bottomPadding4,
                      bottomPadding4,
                      bottomPadding4,
                      _bottomPadding,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        if (_replyMessage.message.isNotEmpty)
                          Container(
                            decoration: BoxDecoration(
                              color: widget.sendMessageConfig
                                      ?.textFieldBackgroundColor ??
                                  Colors.white,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(14)),
                            ),
                            margin: const EdgeInsets.only(
                              bottom: 17,
                              right: 0.4,
                              left: 0.4,
                            ),
                            padding: const EdgeInsets.fromLTRB(
                              leftPadding,
                              leftPadding,
                              leftPadding,
                              30,
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 2),
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 6,
                              ),
                              decoration: BoxDecoration(
                                color: widget
                                        .sendMessageConfig?.replyDialogColor ??
                                    Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${PackageStrings.replyTo} $_replyTo",
                                        style: TextStyle(
                                          color: widget.sendMessageConfig
                                                  ?.replyTitleColor ??
                                              Colors.deepPurple,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.25,
                                        ),
                                      ),
                                      IconButton(
                                        constraints: const BoxConstraints(),
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          Icons.close,
                                          color: widget.sendMessageConfig
                                                  ?.closeIconColor ??
                                              Colors.black,
                                          size: 16,
                                        ),
                                        onPressed: _onCloseTap,
                                      ),
                                    ],
                                  ),
                                  _replyMessage.messageType.isImage
                                      ? Row(
                                          children: [
                                            Icon(
                                              Icons.photo,
                                              size: 20,
                                              color: widget.sendMessageConfig
                                                      ?.replyMessageColor ??
                                                  Colors.grey.shade700,
                                            ),
                                            Text(
                                              PackageStrings.photo,
                                              style: TextStyle(
                                                color: widget.sendMessageConfig
                                                        ?.replyMessageColor ??
                                                    Colors.black,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          _replyMessage.message,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: widget.sendMessageConfig
                                                    ?.replyMessageColor ??
                                                Colors.black,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ChatUITextField(
                          focusNode: _focusNode,
                          textEditingController: _textEditingController,
                          onPressed: _onPressed,
                          sendMessageConfig: widget.sendMessageConfig,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void _onPressed() {
    if (_textEditingController.text.isNotEmpty &&
        !_textEditingController.text.startsWith('\n')) {
      widget.onSendTap(_textEditingController.text, _replyMessage);
      if (_replyMessage.message.isNotEmpty) {
        setState(() => _replyMessage = ReplyMessage());
      }
      _textEditingController.clear();
    }
  }

  void assignReplyMessage(Message message) {
    setState(() {
      _replyMessage = ReplyMessage(
        message: message.message,
        replyBy: widget.sender.id,
        replyTo: message.sendBy,
        messageType: message.messageType,
      );
    });
    FocusScope.of(context).requestFocus(_focusNode);
    if (widget.onReplyCallback != null) widget.onReplyCallback!(_replyMessage);
  }

  void _onCloseTap() {
    setState(() => _replyMessage = ReplyMessage());
    if (widget.onReplyCloseCallback != null) widget.onReplyCloseCallback!();
  }

  double get _bottomPadding => (!kIsWeb && Platform.isIOS)
      ? (_focusNode.hasFocus
          ? bottomPadding1
          : window.viewPadding.bottom > 0
              ? bottomPadding2
              : bottomPadding3)
      : bottomPadding3;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
