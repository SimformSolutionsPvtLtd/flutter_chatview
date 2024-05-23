import 'package:flutter/material.dart';

import '../controller/chat_controller.dart';
import '../models/models.dart';
import 'profile_image_widget.dart';

class ReactionsBottomSheet {
  Future<void> show({
    required BuildContext context,

    /// Provides reaction instance of message.
    required Reaction reaction,

    /// Provides controller for accessing few function for running chat.
    required ChatController chatController,

    /// Provides configuration of reaction bottom sheet appearance.
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
              return GestureDetector(
                onTap: () {
                  reactionsBottomSheetConfig?.reactedUserCallback?.call(
                    reactedUser,
                    reaction.reactions[index],
                  );
                },
                child: Container(
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
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                  child: Row(
                    children: [
                      ProfileImageWidget(
                        circleRadius:
                            reactionsBottomSheetConfig?.profileCircleRadius ??
                                16,
                        imageUrl: reactedUser.profilePhoto,
                        imageType: reactedUser.imageType,
                        defaultAvatarImage: reactedUser.defaultAvatarImage,
                        assetImageErrorBuilder:
                            reactedUser.assetImageErrorBuilder,
                        networkImageErrorBuilder:
                            reactedUser.networkImageErrorBuilder,
                        networkImageProgressIndicatorBuilder:
                            reactedUser.networkImageProgressIndicatorBuilder,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          reactedUser.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              reactionsBottomSheetConfig?.reactedUserTextStyle,
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
                ),
              );
            },
          ),
        );
      },
    );
  }
}
