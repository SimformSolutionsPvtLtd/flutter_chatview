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

  /// Used for enable/disable swipe to reply.
  final bool enableSwipeToReply;

  /// Used for enable/disable reaction pop-up.
  final bool enableReactionPopup;

  /// Used for enable/disable text field.
  final bool enableTextField;

  /// Used for enable/disable swipe whole chat to see message created time.
  final bool enableSwipeToSeeTime;

  /// Used for enable/disable current user profile circle.
  final bool enableCurrentUserProfileAvatar;

  /// Used for enable/disable other users profile circle.
  final bool enableOtherUserProfileAvatar;

  /// Used for enable/disable reply snack bar when user long press on chat-bubble.
  final bool enableReplySnackBar;

  /// Used for enable/disable pagination.
  final bool enablePagination;

  /// Used for enable/disable chat separator widget.
  final bool enableChatSeparator;

  /// Used for enable/disable double tap to like message.
  final bool enableDoubleTapToLike;
}
