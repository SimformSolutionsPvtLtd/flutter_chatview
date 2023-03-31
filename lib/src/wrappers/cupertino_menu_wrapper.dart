import 'package:chatview/chatview.dart';
import 'package:chatview/src/models/cupertino_widget_model/cupertino_context.dart';
import 'package:chatview/src/widgets/chat_view_inherited_widget.dart';
import 'package:chatview/src/widgets/default_reaction_popup_widget.dart';
import 'package:chatview/src/wrappers/material_conditional_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/emoji_row.dart';
import '../widgets/glassmorphism_reaction_popup.dart';
import '../widgets/reactions_bottomsheet.dart';

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
              userId: widget.message.sendBy);
        });
      });

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
        previewBuilder: (context, animation, child) {
          widget.chatController.focusNode.unfocus();
          return SingleChildScrollView(
              child: menuConfiguration?.previewBuilder?.call(
                      context, animation, widget.message, emojiRow, child) ??
                  Column(
                    children: [
                      Padding(
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
                      AbsorbPointer(
                          absorbing: menuConfiguration?.ignorePointer ?? true,
                          child: child),
                    ],
                  ));
        },
        actions: menuConfiguration?.actionsBuilder?.call(widget.message) ??
            <Widget>[
              if (menuActionConfig.showCopyMenu)
                CupertinoContextMenuAction(
                  onPressed:
                      menuActionConfig.copyOnPressed?.call(widget.message) ??
                          () async {
                            await Clipboard.setData(
                                ClipboardData(text: widget.message.message));
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
                  onPressed: menuActionConfig.favoriteOnPressed
                          ?.call(widget.message) ??
                      () {
                        Navigator.pop(context);
                      },
                  trailingIcon: menuActionConfig.favoriteIcon,
                  child: menuActionConfig.favoriteWidget,
                ),
              if (menuActionConfig.showReactionsMenu)
                CupertinoContextMenuAction(
                  onPressed: menuActionConfig.reactionsOnPressed
                          ?.call(widget.message) ??
                      () {
                        Navigator.pop(context);
                        if (widget.message.reaction.reactions.isNotEmpty) {
                          ReactionsBottomSheet().show(
                            context: context,
                            reaction: widget.message.reaction,
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
        child: widget.child);
  }
}
