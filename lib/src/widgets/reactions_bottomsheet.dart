import 'package:chatview/src/controller/chat_controller.dart';
import 'package:chatview/src/models/models.dart';
import 'package:chatview/src/utils/constants.dart';
import 'package:flutter/material.dart';

class ReactionsBottomSheet {
  Future<void> show({
    required BuildContext context,
    required Reaction reaction,
    required ChatController chatController,
    required ReactionsBottomSheetConfiguration? reactionsBottomSheetConfig,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          color: reactionsBottomSheetConfig?.backgroundColor,
          child: ListView.builder(
            padding: reactionsBottomSheetConfig?.bottomSheetPadding ??
                const EdgeInsets.only(
                  right: 12,
                  left: 12,
                  top: 18,
                ),
            itemCount: reaction.reactedUserIds.length,
            itemBuilder: (_, index) {
              final reactedUser =
                  chatController.getUserFromId(reaction.reactedUserIds[index]);
              return Container(
                margin: reactionsBottomSheetConfig?.reactionWidgetMargin ??
                    const EdgeInsets.only(bottom: 8),
                padding: reactionsBottomSheetConfig?.reactionWidgetPadding ??
                    const EdgeInsets.all(8),
                decoration:
                    reactionsBottomSheetConfig?.reactionWidgetDecoration ??
                        BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              offset: const Offset(0, 20),
                              blurRadius: 40,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: reactionsBottomSheetConfig
                                    ?.profileCircleRadius ??
                                16,
                            backgroundImage: NetworkImage(
                              reactedUser.profilePhoto ?? profileImage,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            reactedUser.name,
                            style: reactionsBottomSheetConfig
                                ?.reactedUserTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      reaction.reactions[index],
                      style: TextStyle(
                        fontSize:
                            reactionsBottomSheetConfig?.reactionSize ?? 14,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
