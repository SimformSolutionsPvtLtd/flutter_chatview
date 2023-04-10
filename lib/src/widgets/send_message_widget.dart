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

part of '../../chatview.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({
    Key? key,
    required this.onSendTap,
    required this.chatController,
    this.sendMessageConfig,
    this.backgroundColor,
    this.sendMessageBuilder,
    this.onReplyCallback,
    required this.replyMessageNotfier,
    this.onReplyCloseCallback,
  }) : super(key: key);

  /// Provides call back when user tap on send button on text field.
  final StringMessageCallBack onSendTap;

  /// Provides configuration for text field appearance.
  final SendMessageConfiguration? sendMessageConfig;

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

  final ValueNotifier<Message?> replyMessageNotfier;

  @override
  State<SendMessageWidget> createState() => SendMessageWidgetState();
}

class SendMessageWidgetState extends State<SendMessageWidget> {
  final _textEditingController = InputTextFieldController();

  final ValueNotifier<Message?> _replyMessage = ValueNotifier(null);

  Message? get replyMessage => _replyMessage.value;
  final _focusNode = FocusNode();

  ChatUser? get repliedUser =>
      replyMessage?.author != null ? replyMessage?.author : null;

  String get _replyTo => replyMessage?.author.id == currentUser?.id
      ? PackageStrings.you
      : repliedUser?.firstName ?? '';

  ChatUser? currentUser;

  ChatController get chatController =>
      ChatViewInheritedWidget.of(context)!.chatController;

  @override
  void initState() {
    widget.replyMessageNotfier.addListener(() {
      _replyMessage.value = widget.replyMessageNotfier.value;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provide != null) {
      currentUser = provide!.currentUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    final replyTitle = "${PackageStrings.replyTo} $_replyTo";
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
                        ValueListenableBuilder<Message?>(
                          builder: (_, state, child) {
                            if (state != null) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: widget.sendMessageConfig
                                          ?.textFieldBackgroundColor ??
                                      Colors.white,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(14),
                                  ),
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
                                    color: widget.sendMessageConfig
                                            ?.replyDialogColor ??
                                        Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            replyTitle,
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
                                      if (state.type.isVoice)
                                        _voiceReplyMessageView
                                      else if (state.type.isImage)
                                        _imageReplyMessageView
                                      else
                                        (() {
                                          state as TextMessage;
                                          return Text(
                                            state.text,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: widget.sendMessageConfig
                                                      ?.replyMessageColor ??
                                                  Colors.black,
                                            ),
                                          );
                                        }())
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                          valueListenable: _replyMessage,
                        ),
                        ChatUITextField(
                          focusNode: chatController.focusNode,
                          chatController: widget.chatController,
                          textEditingController: _textEditingController,
                          onPressed: _onPressed,
                          sendMessageConfig: widget.sendMessageConfig,
                          onRecordingComplete: _onRecordingComplete,
                          onImageSelected: _onImageSelected,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget get _voiceReplyMessageView {
    final msg = replyMessage as AudioMessage?;
    return Row(
      children: [
        Icon(
          Icons.mic,
          color: widget.sendMessageConfig?.micIconColor,
        ),
        const SizedBox(width: 4),
        if (msg != null)
          Text(
            Duration(milliseconds: msg.duration).toHHMMSS(),
            style: TextStyle(
              fontSize: 12,
              color:
                  widget.sendMessageConfig?.replyMessageColor ?? Colors.black,
            ),
          ),
      ],
    );
  }

  Widget get _imageReplyMessageView {
    return Row(
      children: [
        Icon(
          Icons.photo,
          size: 20,
          color: widget.sendMessageConfig?.replyMessageColor ??
              Colors.grey.shade700,
        ),
        Text(
          PackageStrings.photo,
          style: TextStyle(
            color: widget.sendMessageConfig?.replyMessageColor ?? Colors.black,
          ),
        ),
      ],
    );
  }

  void _onRecordingComplete(String? path, Duration? duration) {
    if (path != null) {
      widget.onSendTap
          .call(path, replyMessage, MessageType.voice, duration: duration);
      _assignRepliedMessage();
    }
  }

  void _onImageSelected(String imagePath, String error) {
    if (imagePath.isNotEmpty) {
      widget.onSendTap.call(imagePath, replyMessage, MessageType.image);
      _assignRepliedMessage();
    }
  }

  void _assignRepliedMessage() {
    if (replyMessage != null) {
      _replyMessage.value = null;
    }
  }

  void _onPressed() {
    if (_textEditingController.text.isNotEmpty &&
        !_textEditingController.text.startsWith('\n')) {
      widget.onSendTap.call(
        _textEditingController.text.trim(),
        replyMessage,
        MessageType.text,
      );
      _assignRepliedMessage();
      _textEditingController.clear();
    }
  }

  void assignReplyMessage(Message message) {
    if (currentUser != null) {
      _replyMessage.value = message;
    }
    FocusScope.of(context).requestFocus(chatController.focusNode);
    if (widget.onReplyCallback != null) widget.onReplyCallback!(replyMessage!);
  }

  void _onCloseTap() {
    _replyMessage.value = null;
    if (widget.onReplyCloseCallback != null) widget.onReplyCloseCallback!();
  }

  double get _bottomPadding => (!kIsWeb && Platform.isIOS)
      ? (chatController.focusNode.hasFocus
          ? bottomPadding1
          : window.viewPadding.bottom > 0
              ? bottomPadding2
              : bottomPadding3)
      : bottomPadding3;

  @override
  void dispose() {
    _textEditingController.dispose();
    chatController.focusNode.dispose();
    _replyMessage.dispose();
    super.dispose();
  }
}
