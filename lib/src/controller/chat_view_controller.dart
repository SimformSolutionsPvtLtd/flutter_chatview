import 'package:chatview/chatview.dart';

/// To get instance
///
/// ```dart
/// const user = ChatUser(id: 'fdslhf-dfsa854-sf784-', firstName: 'Flutter');
///
/// final ChatViewController _chatViewController = const ChatViewController(user);
/// ```
/// `ChatViewController` controls whole chat infrastructure. It is the
/// entry point for the extension API. All extensions are registered here,
/// Through  `ChatViewController` one can control backend, manage databases and
/// rooms. `ChatViewController` is singleton.
class ChatViewController {
  const ChatViewController._(this.currentUser, {this.chatViewExtension});

  static ChatViewController? _instance;

  static ChatViewController getInstance(ChatUser currentUser,
      {ChatViewExtension? chatViewExtension}) {
    _instance ??=
        ChatViewController._(currentUser, chatViewExtension: chatViewExtension);
    return _instance!;
  }

  final ChatUser currentUser;

  final ChatViewExtension? chatViewExtension;
}
