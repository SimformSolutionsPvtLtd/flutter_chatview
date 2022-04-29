import 'package:flutter/material.dart';

import 'reply_icon.dart';

class SwipeToReply extends StatefulWidget {
  const SwipeToReply({
    Key? key,
    this.onLeftSwipe,
    required this.child,
    this.replyIconColor,
    this.onRightSwipe,
    this.swipeToReplyAnimationDuration,
  }) : super(key: key);
  final VoidCallback? onRightSwipe;
  final VoidCallback? onLeftSwipe;
  final Widget child;
  final Color? replyIconColor;
  final Duration? swipeToReplyAnimationDuration;

  @override
  _SwipeToReplyState createState() => _SwipeToReplyState();
}

class _SwipeToReplyState extends State<SwipeToReply>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _leftScaleAnimation;
  late Animation<double> _rightScaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimationControllers();
  }

  void _initializeAnimationControllers() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.swipeToReplyAnimationDuration ??
          const Duration(milliseconds: 250),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(curve: Curves.decelerate, parent: _controller));
    _leftScaleAnimation = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.0),
    );
    _rightScaleAnimation = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            fit: StackFit.passthrough,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Visibility(
                    visible: widget.onRightSwipe != null,
                    child: ReplyIcon(
                      scaleAnimation: _leftScaleAnimation,
                      slideAnimation: _slideAnimation,
                      replyIconColor: widget.replyIconColor,
                    ),
                  ),
                  Visibility(
                    visible: widget.onLeftSwipe != null,
                    child: ReplyIcon(
                      scaleAnimation: _rightScaleAnimation,
                      slideAnimation: _slideAnimation,
                      replyIconColor: widget.replyIconColor,
                    ),
                  ),
                ],
              ),
              SlideTransition(
                position: _slideAnimation,
                child: widget.child,
              ),
            ],
          );
        },
      ),
    );
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (widget.onRightSwipe != null && details.delta.dx > 1) {
      _runAnimation(onRight: true);
    }
    if (widget.onLeftSwipe != null && details.delta.dx < -1) {
      _runAnimation(onRight: false);
    }
  }

  void _runAnimation({required bool onRight}) {
    _slideAnimation = Tween(
      begin: const Offset(0.0, 0.0),
      end: Offset(onRight ? 0.1 : -0.1, 0.0),
    ).animate(CurvedAnimation(curve: Curves.decelerate, parent: _controller));
    if (onRight) {
      _leftScaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(curve: Curves.decelerate, parent: _controller));
    } else {
      _rightScaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(curve: Curves.decelerate, parent: _controller));
    }
    _controller.forward().whenComplete(() {
      _controller.reverse().whenComplete(() {
        if (onRight) {
          _leftScaleAnimation = _controller.drive(Tween(begin: 0.0, end: 0.0));
          if (widget.onRightSwipe != null) widget.onRightSwipe!();
        } else {
          _rightScaleAnimation = _controller.drive(Tween(begin: 0.0, end: 0.0));
          if (widget.onLeftSwipe != null) widget.onLeftSwipe!();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
