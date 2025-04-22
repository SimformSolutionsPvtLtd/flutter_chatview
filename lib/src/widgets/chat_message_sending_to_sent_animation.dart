import 'dart:math';

import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';

class SendingMessageAnimatingWidget extends StatefulWidget {
  const SendingMessageAnimatingWidget(this.status, {Key? key})
      : super(key: key);

  final MessageStatus status;

  @override
  State<SendingMessageAnimatingWidget> createState() =>
      _SendingMessageAnimatingWidgetState();
}

class _SendingMessageAnimatingWidgetState
    extends State<SendingMessageAnimatingWidget> with TickerProviderStateMixin {
  bool get isSent => widget.status != MessageStatus.pending;

  bool isVisible = false;

  _attachOnStatusChangeListeners() {
    if (isSent) {
      Future.delayed(const Duration(milliseconds: 200), () {
        isVisible = true;
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _attachOnStatusChangeListeners();

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: SizedBox(
        width: !isVisible ? 16 : 0,
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 600),
          tween: Tween(begin: 0, end: isVisible ? 100 : 0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(value, 0),
              child: child,
            );
          },
          child: Transform.rotate(
              key: const ValueKey(1),
              angle: !isSent ? pi / 10 : -pi / 12,
              child: const Padding(
                padding: EdgeInsets.only(
                  left: 2,
                  bottom: 5,
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.grey,
                  size: 20,
                ),
              )),
        ),
      ),
    );
  }
}
