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

class ReactionPopup extends StatefulWidget {
  const ReactionPopup({
    Key? key,
    this.reactionPopupConfig,
    required this.onTap,
    required this.showPopUp,
  }) : super(key: key);

  /// Provides configuration of reaction pop-up appearance.
  final ReactionPopupConfiguration? reactionPopupConfig;

  /// Provides call back when user taps on reaction pop-up.
  final VoidCallBack onTap;

  /// Represents should pop-up show or not.
  final bool showPopUp;

  @override
  ReactionPopupState createState() => ReactionPopupState();
}

class ReactionPopupState extends State<ReactionPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  bool isCupertino = false;

  ReactionPopupConfiguration? get reactionPopupConfig =>
      widget.reactionPopupConfig;

  bool get showPopUp => widget.showPopUp;
  double _yCoordinate = 0.0;
  double _xCoordinate = 0.0;
  Message? _message;

  ChatController? chatController;
  ChatUser? currentUser;

  @override
  void initState() {
    super.initState();
    _initializeAnimationControllers();
  }

  void _initializeAnimationControllers() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.reactionPopupConfig?.animationDuration ??
          const Duration(milliseconds: 180),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeInOutSine,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provide != null) {
      chatController = provide!.chatController;
      currentUser = provide!.currentUser;
      isCupertino = provide!.isCupertinoApp;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final toolTipWidth = deviceWidth > 450 ? 450 : deviceWidth;
    if (showPopUp) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    return showPopUp
        ? Positioned(
            top: _yCoordinate,
            left: _xCoordinate + toolTipWidth > deviceWidth
                ? deviceWidth - toolTipWidth
                : _xCoordinate - (toolTipWidth / 2) < 0
                    ? 0
                    : _xCoordinate - (toolTipWidth / 2),
            child: SizedBox(
              width: deviceWidth > 450 ? 450 : deviceWidth,
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) => Transform.scale(
                    scale: _scaleAnimation.value,
                    child: reactionPopupConfig?.showGlassMorphismEffect ?? false
                        ? GlassMorphismReactionPopup(
                            isCupertino: isCupertino,
                            reactionPopupConfig: reactionPopupConfig,
                            child: _reactionPopupRow,
                          )
                        : DefaultReactionPopup(
                            reactionPopupRow: _reactionPopupRow,
                            reactionPopupConfig: reactionPopupConfig,
                          )),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget get _reactionPopupRow => EmojiRow(
        onEmojiTap: (emoji) {
          widget.onTap();
          if (currentUser != null && _message != null) {
            reactionPopupConfig?.userReactionCallback?.call(
              _message!,
              emoji,
            );
            chatController?.setReaction(
              emoji: emoji,
              messageId: _message!.id,
              userId: currentUser!.id,
            );
          }
        },
        emojiConfiguration: reactionPopupConfig?.emojiConfig,
      );

  void refreshWidget({
    required Message message,
    required double xCoordinate,
    required double yCoordinate,
  }) {
    if (mounted) {
      setState(() {
        _message = message;
        _xCoordinate = xCoordinate;
        _yCoordinate = yCoordinate;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
