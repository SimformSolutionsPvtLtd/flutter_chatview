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


class ChatViewAppBar extends StatefulWidget {
  const ChatViewAppBar({
    Key? key,
    required this.chatTitle,
    this.backGroundColor,
    this.userStatus,
    this.profilePicture,
    this.chatTitleTextStyle,
    this.userStatusTextStyle,
    this.backArrowColor,
    this.actions,
    this.elevation,
    this.onBackPress,
    this.padding,
    this.leading,
    this.showLeading = true,
    this.messageActionsBuilder,
  }) : super(key: key);

  /// Allow user to change colour of appbar.
  final Color? backGroundColor;

  /// Allow user to change title of appbar.
  final String chatTitle;

  /// Allow user to change whether user is available or offline.
  final String? userStatus;

  /// Allow user to change profile picture in appbar.
  final String? profilePicture;

  /// Allow user to change text style of chat title.
  final TextStyle? chatTitleTextStyle;

  /// Allow user to change text style of user status.
  final TextStyle? userStatusTextStyle;

  /// Allow user to change back arrow colour.
  final Color? backArrowColor;

  /// Allow user to add actions widget in right side of appbar.
  final List<Widget>? actions;

  /// Allow user to change elevation of appbar.
  final double? elevation;

  /// Provides callback when user tap on back arrow.
  final VoidCallBack? onBackPress;

  /// Allow user to change padding in appbar.
  final EdgeInsets? padding;

  /// Allow user to change leading icon of appbar.
  final Widget? leading;

  /// Allow user to turn on/off leading icon.
  final bool showLeading;

  final List<Widget> Function(Message message)? messageActionsBuilder;

  @override
  State<ChatViewAppBar> createState() => _ChatViewAppBarState();
}

class _ChatViewAppBarState extends State<ChatViewAppBar> {
  ChatController get chatController =>
      ChatViewInheritedWidget.of(context)!.chatController;

  bool get isCupertino => ChatViewInheritedWidget.of(context)!.isCupertinoApp;

  int get profileRadius => 20;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation ?? 1,
      child: Container(
        padding: widget.padding ??
            EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: 4,
            ),
        color: widget.backGroundColor ?? Colors.white,
        child: Row(
          children: [
            if (widget.showLeading)
              widget.leading ??
                  IconButton(
                    onPressed:
                        widget.onBackPress ?? () => Navigator.pop(context),
                    icon: Icon(
                      (!kIsWeb && Platform.isIOS)
                          ? Icons.arrow_back_ios
                          : Icons.arrow_back,
                      color: widget.backArrowColor,
                    ),
                  ),
            Expanded(
              child: Row(
                children: [
                  if (widget.profilePicture != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(

                          /// TODO: Provide user to control over radius property.
                          radius: profileRadius.toDouble(),
                          child: Image.network(
                            widget.profilePicture!,
                            cacheHeight: profileRadius * 2,
                            cacheWidth: profileRadius * 2,
                          )),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatTitle,
                        style: widget.chatTitleTextStyle ??
                            const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.25,
                            ),
                      ),
                      if (widget.userStatus != null)
                        Text(
                          widget.userStatus!,
                          style: widget.userStatusTextStyle,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: chatController.showMessageActions,
              builder: (context, message, child) {
                message as Message?;
                if (message != null && widget.messageActionsBuilder != null) {
                  return Row(
                      children: widget.messageActionsBuilder!.call(message));
                } else if (widget.actions != null) {
                  return Row(
                    children: widget.actions!,
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
