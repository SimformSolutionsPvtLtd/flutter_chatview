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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'reply_icon.dart';

enum SwipeToReplyType {
  leftRight,
  inwardsOutwards,
}

class SwipeToReply extends StatefulWidget {
  const SwipeToReply({
    Key? key,
    required this.child,
    required this.isMessageBySender,
    this.replyIconColor,
    this.onSwipeOutwards,
    this.onSwipeInwards,
    this.onSwipeLeft,
    this.onSwipeRight,
  })  : assert(
          (onSwipeInwards == null &&
                  onSwipeOutwards == null &&
                  onSwipeLeft == null &&
                  onSwipeRight == null) ||
              ((onSwipeInwards != null || onSwipeOutwards != null) &&
                  onSwipeLeft == null &&
                  onSwipeRight == null) ||
              ((onSwipeLeft != null || onSwipeRight != null) &&
                  onSwipeInwards == null &&
                  onSwipeOutwards == null),
          'You can either set onSwipeLeft and/or onSwipeRight,'
          'but onSwipeInwards and onSwipeOutwards have to be null or'
          'the other way around; or all swipe actions have to be null',
        ),
        super(key: key);

  /// Provides callback when user swipes chat bubble into the middle.
  final VoidCallback? onSwipeInwards;

  /// Provides callback when user swipes chat bubble to the edge of the view.
  final VoidCallback? onSwipeOutwards;

  /// Provides callback when user swipes chat bubble to the left.
  final VoidCallback? onSwipeLeft;

  /// Provides callback when user swipes chat bubble to the right.
  final VoidCallback? onSwipeRight;

  /// Handles message mirrored if true compared to if false
  final bool isMessageBySender;

  /// Allow user to set widget which is showed while user swipes chat bubble.
  final Widget child;

  /// Allow user to change colour of reply icon which is showed while user swipes.
  final Color? replyIconColor;

  SwipeToReplyType get swipeToReplyType =>
      (onSwipeLeft != null || onSwipeRight != null)
          ? SwipeToReplyType.leftRight
          : SwipeToReplyType.inwardsOutwards;

  @override
  State<SwipeToReply> createState() => _SwipeToReplyState();
}

class _SwipeToReplyState extends State<SwipeToReply>
    with SingleTickerProviderStateMixin {
  ValueNotifier<double> valueListener = ValueNotifier(0);

  double clampLower = -0.25;
  double clampUpper = 1.0;

  double get clampOuter => widget.onSwipeOutwards != null ? clampLower : 0;
  double get clampInner => widget.onSwipeInwards != null ? clampUpper : 0;

  double innerBoundThreshold = 0.7;
  double outerBoundThreshold = 0.8;

  double get innerBound =>
      (widget.isMessageBySender ? -clampLower : clampUpper) *
      innerBoundThreshold;
  double get outerBound =>
      (widget.isMessageBySender ? -clampUpper : clampLower) *
      outerBoundThreshold;

  bool get isInwardsOutwardsSwiper =>
      widget.swipeToReplyType == SwipeToReplyType.inwardsOutwards;

  @override
  void initState() {
    super.initState();
    if (widget.isMessageBySender && isInwardsOutwardsSwiper) {
      var tmp = clampLower;
      clampLower = -clampUpper;
      clampUpper = -tmp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (kDebugMode) {
          print('valueListener.value on release: ${valueListener.value}');
        }

        if (isInwardsOutwardsSwiper) {
          // Handle inwards and outwards
          final valueOnRelease =
              valueListener.value * (widget.isMessageBySender ? -1 : 1);

          if (valueOnRelease < 0 && valueOnRelease < outerBound) {
            widget.onSwipeOutwards?.call();
          } else if (valueOnRelease > 0 && valueOnRelease > innerBound) {
            widget.onSwipeInwards?.call();
          }
        } else {
          // Handle left and right
          if (valueListener.value < 0 && valueListener.value < clampLower / 2) {
            widget.onSwipeLeft?.call();
          } else if (valueListener.value > 0 &&
              valueListener.value > clampUpper / 2) {
            widget.onSwipeRight?.call();
          }
        }
        valueListener.value = 0;
      },
      onHorizontalDragUpdate: (details) {
        valueListener.value = (valueListener.value +
                (details.delta.dx / context.size!.width) * 4.5)
            .clamp(clampLower, clampUpper);
      },
      child: AnimatedBuilder(
        animation: valueListener,
        builder: (context, child) {
          var dragValue = valueListener.value *
              ((widget.isMessageBySender && isInwardsOutwardsSwiper) ? -1 : 1);

          // This widget is handling right and inwards swiping
          final inwardsWidget = Visibility(
            visible:
                ((isInwardsOutwardsSwiper && widget.onSwipeInwards != null) ||
                        widget.onSwipeRight != null) &&
                    dragValue > 0,
            child: ReplyIcon(
              scaleValue: dragValue,
              replyIconColor: widget.replyIconColor,
            ),
          );

          // This widget is handling left and outwards swiping
          final outwardsWidget = Visibility(
            visible:
                ((isInwardsOutwardsSwiper && widget.onSwipeOutwards != null) ||
                        widget.onSwipeLeft != null) &&
                    dragValue < 0,
            child: ReplyIcon(
              scaleValue: dragValue,
              replyIconColor: widget.replyIconColor,
            ),
          );

          final actionIndicators = [inwardsWidget, outwardsWidget];
          return Stack(
            alignment: Alignment.center,
            fit: StackFit.passthrough,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: widget.isMessageBySender && isInwardsOutwardsSwiper
                    ? actionIndicators.reversed.toList()
                    : actionIndicators,
              ),
              Align(
                alignment: widget.isMessageBySender
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Transform.translate(
                  offset: Offset(valueListener.value * 35, 0),
                  child: Container(
                    color: Colors.transparent,
                    constraints: const BoxConstraints(minWidth: 150),
                    child: widget.child,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
