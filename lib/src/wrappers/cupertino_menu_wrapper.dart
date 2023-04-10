part of '../../chatview.dart';

class CupertinoMenuWrapper extends StatefulWidget {
  const CupertinoMenuWrapper(
      {Key? key,
      required this.child,
      required this.message,
      required this.chatController,
      this.messageConfig,
      this.reactionPopupConfig})
      : super(key: key);

  final Widget child;
  final Message message;
  final ChatController chatController;
  final MessageConfiguration? messageConfig;
  final ReactionPopupConfiguration? reactionPopupConfig;

  @override
  State<CupertinoMenuWrapper> createState() => _CupertinoMenuWrapperState();
}

class _CupertinoMenuWrapperState extends State<CupertinoMenuWrapper> {
  void get pop => mounted ? Navigator.pop(context) : null;

  bool isReversed = false;

  CupertinoMenuConfiguration? get menuConfiguration =>
      ChatViewInheritedWidget.of(context)
          ?.cupertinoWidgetConfig
          ?.cupertinoMenuConfig;
  DefaultMenuActionsConfiguration get menuActionConfig =>
      menuConfiguration?.defaultMenuActionsConfigurations ??
      const DefaultMenuActionsConfiguration();

  Widget get emojiRow => EmojiRow(
      isCupertino: true,
      onEmojiTap: (e) {
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 500), () {
          widget.chatController.setReaction(
              emoji: e,
              messageId: widget.message.id,
              userId: widget.message.author.id);
        });
      });

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu.builder(
      builder: (context, animation) {
        animation.addStatusListener((status) {
          if (status.name == 'completed') {
            Future.delayed(const Duration(milliseconds: 200), () {
              isReversed = true;
            });
          } else {
            isReversed = false;
          }
          setState(() {});
        });
        return isReversed
            ? SingleChildScrollView(
                child: menuConfiguration?.previewBuilder?.call(context,
                        animation, widget.message, emojiRow, widget.child) ??
                    Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          height: isReversed ? null : 0,
                          child: Padding(
                            padding: menuConfiguration?.padding ??
                                const EdgeInsets.all(8.0),
                            child: MaterialConditionalWrapper(
                                condition: true,
                                child: widget.reactionPopupConfig
                                            ?.showGlassMorphismEffect ??
                                        false
                                    ? GlassMorphismReactionPopup(
                                        isCupertino: true,
                                        child: emojiRow,
                                      )
                                    : DefaultReactionPopup(
                                        reactionPopupConfig:
                                            widget.reactionPopupConfig,
                                        reactionPopupRow: emojiRow,
                                      )),
                          ),
                        ),
                        AbsorbPointer(
                            absorbing: menuConfiguration?.ignorePointer ?? true,
                            child: widget.child),
                      ],
                    ))
            : widget.child;
      },
      actions: menuConfiguration?.actionsBuilder?.call(widget.message) ??
          <Widget>[
            if (menuActionConfig.showCopyMenu)
              CupertinoContextMenuAction(
                onPressed:
                    menuActionConfig.copyOnPressed?.call(widget.message) ??
                        () async {
                          /// TODO: Copy Message.
                          // await Clipboard.setData(
                          //     ClipboardData(text: widget.message.message));
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        },
                trailingIcon: menuActionConfig.copyIcon,
                child: menuActionConfig.copyWidget,
              ),
            if (menuActionConfig.showShareMenu)
              CupertinoContextMenuAction(
                onPressed:
                    menuActionConfig.shareOnPressed?.call(widget.message) ??
                        () {
                          Navigator.pop(context);
                        },
                trailingIcon: menuActionConfig.shareIcon,
                child: menuActionConfig.shareWidget,
              ),
            if (menuActionConfig.showfavoriteMenu)
              CupertinoContextMenuAction(
                onPressed:
                    menuActionConfig.favoriteOnPressed?.call(widget.message) ??
                        () {
                          Navigator.pop(context);
                        },
                trailingIcon: menuActionConfig.favoriteIcon,
                child: menuActionConfig.favoriteWidget,
              ),
            if (menuActionConfig.showReactionsMenu)
              CupertinoContextMenuAction(
                onPressed:
                    menuActionConfig.reactionsOnPressed?.call(widget.message) ??
                        () {
                          Navigator.pop(context);
                          if (widget.message.reaction?.reactions.isNotEmpty ??
                              false) {
                            ReactionsBottomSheet().show(
                              context: context,
                              reaction: widget.message.reaction!,
                              chatController: widget.chatController,
                              reactionsBottomSheetConfig: widget
                                  .messageConfig
                                  ?.messageReactionConfig
                                  ?.reactionsBottomSheetConfig,
                            );
                          }
                        },
                trailingIcon: menuActionConfig.reactionsIcon,
                child: menuActionConfig.reactionsWidget,
              ),
            if (menuActionConfig.showDeleteMenu)
              CupertinoContextMenuAction(
                onPressed:
                    menuActionConfig.deleteOnPressed?.call(widget.message) ??
                        () {
                          Navigator.pop(context);
                        },
                isDestructiveAction: true,
                trailingIcon: menuActionConfig.deleteIcon,
                child: menuActionConfig.deleteWidget,
              ),
          ],
    );
  }
}
