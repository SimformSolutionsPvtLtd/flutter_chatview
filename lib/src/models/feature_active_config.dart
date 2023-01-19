class FeatureActiveConfig {
  const FeatureActiveConfig({
    this.enableSwipeToReply = true,
    this.enableReactionPopup = true,
    this.enableTextField = true,
    this.enableSwipeToSeeTime = true,
    this.enableCurrentUserProfileAvatar = false,
    this.enableOtherUserProfileAvatar = true,
    this.enableReplySnackBar = true,
    this.enablePagination = false,
    this.enableChatSeparator = true,
    this.enableDoubleTapToLike = true,
  });

  final bool enableSwipeToReply;
  final bool enableReactionPopup;
  final bool enableTextField;
  final bool enableSwipeToSeeTime;
  final bool enableCurrentUserProfileAvatar;
  final bool enableOtherUserProfileAvatar;
  final bool enableReplySnackBar;
  final bool enablePagination;
  final bool enableChatSeparator;
  final bool enableDoubleTapToLike;
}
