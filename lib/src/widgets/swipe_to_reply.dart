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
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'reply_icon.dart';

class SwipeToReply extends StatefulWidget {
  const SwipeToReply({
    Key? key,
    this.onLeftSwipe,
    required this.child,
    this.onRightSwipe,
  }) : super(key: key);

  /// Provides callback when user swipes chat bubble from right side.
  final VoidCallback? onRightSwipe;

  /// Provides callback when user swipes chat bubble from left side.
  final VoidCallback? onLeftSwipe;

  /// Allow user to set widget which is showed while user swipes chat bubble.
  final Widget child;

  @override
  State<SwipeToReply> createState() => _SwipeToReplyState();
}

class _SwipeToReplyState extends State<SwipeToReply> {
  double paddingValue = 0;
  double trackPaddingValue = 0;
  double initialTouchPoint = 0;
  bool isCallBackTriggered = false;

  late bool isMessageBySender = widget.onLeftSwipe == null;

  final paddingLimit = 50;
  final double replyIconSize = 25;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) =>
          initialTouchPoint = details.globalPosition.dx,
      onHorizontalDragEnd: (details) => setState(
        () {
          paddingValue = 0;
          isCallBackTriggered = false;
        },
      ),
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      child: Stack(
        alignment:
            isMessageBySender ? Alignment.centerLeft : Alignment.centerRight,
        fit: StackFit.passthrough,
        children: [
          Align(
            alignment: widget.onRightSwipe != null
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: ReplyIcon(
              replyIconSize: replyIconSize,
              animationValue: paddingValue > replyIconSize
                  ? (paddingValue) / (paddingLimit)
                  : 0.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: isMessageBySender ? 0 : paddingValue,
              left: isMessageBySender ? paddingValue : 0,
            ),
            child: widget.child,
          ),
        ],
      ),
    );
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!isMessageBySender) {
      final swipeDistance = (initialTouchPoint - details.globalPosition.dx);
      swipeLogic(swipeDistance, widget.onLeftSwipe);
    } else {
      final swipeDistance = (details.globalPosition.dx - initialTouchPoint);
      swipeLogic(swipeDistance, widget.onRightSwipe);
    }
  }

  void swipeLogic(double swipeDistance, VoidCallback? onSwipe) {
    if (swipeDistance >= 0 && trackPaddingValue < paddingLimit) {
      setState(() {
        paddingValue = swipeDistance;
      });
    } else if (paddingValue >= paddingLimit) {
      if (!isCallBackTriggered && onSwipe != null) {
        onSwipe();
        isCallBackTriggered = true;
      }
    } else {
      setState(() {
        paddingValue = 0;
      });
    }

    trackPaddingValue = swipeDistance;
  }
}
