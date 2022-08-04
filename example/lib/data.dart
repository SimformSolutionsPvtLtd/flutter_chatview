import 'package:chatview/chatview.dart';

class Data {
  static const profileImage =
      "https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_showcaseview/master/example/assets/simform.png";
  static final messageList = [
    Message(
      id: '1',
      message: "Hi!",
      createdAt: DateTime.now(),
      sendBy: ChatUser(
          id: '1',
          name: 'Flutter',
          profilePhoto: "https://docs.flutter.dev/assets/images/docs/catalog-widget-placeholder.png",
      ), // userId of who sends the message
    ),
    Message(
      id: '2',
      message: "Hi!",
      createdAt: DateTime.now(),
      sendBy: ChatUser(
        id: '2',
        name: 'Simform',
        profilePhoto: Data.profileImage,
      ),
    ),
    Message(
      id: '3',
      message: "We can meet?I am free",
      createdAt: DateTime.now(),
      sendBy: ChatUser(
        id: '1',
        name: 'Flutter',
        profilePhoto: "https://docs.flutter.dev/assets/images/docs/catalog-widget-placeholder.png",
      ),
    ),
    Message(
      id: '4',
      message: "Can you write the time and place of the meeting?",
      createdAt: DateTime.now(),
      sendBy: ChatUser(
        id: '2',
        name: 'Simform',
        profilePhoto: Data.profileImage,
      ),
    ),
    Message(
      id: '5',
      message: "That's fine",
      createdAt: DateTime.now(),
      sendBy: ChatUser(
        id: '1',
        name: 'Flutter',
        profilePhoto: "https://docs.flutter.dev/assets/images/docs/catalog-widget-placeholder.png",
      ),
      reaction: '❤️',
    ),
    Message(
      id: '6',
      message: "https://bit.ly/3JHS2Wl",
      createdAt: DateTime.now(),
      sendBy: ChatUser(
        id: '1',
        name: 'Flutter',
        profilePhoto: "https://docs.flutter.dev/assets/images/docs/catalog-widget-placeholder.png",
      ),
      replyMessage: ReplyMessage(
        message: "Can you write the time and place of the meeting?",
        replyTo: '1',
        replyBy: '2',
      ),
    ),
    Message(
      id: '7',
      message: "Done",
      createdAt: DateTime.now(),
      sendBy: ChatUser(
        id: '2',
        name: 'Simform',
        profilePhoto: Data.profileImage,
      ),
    ),
    Message(
      id: '8',
      message: "Thank you!!",
      createdAt: DateTime.now(),
      sendBy: ChatUser(
        id: '1',
        name: 'Flutter',
        profilePhoto: "https://docs.flutter.dev/assets/images/docs/catalog-widget-placeholder.png",
      ),
    ),
    Message(
      id: '9',
      message:
          "https://bs-uploads.toptal.io/blackfish-uploads/components/seo/content/og_image_file/og_image/777695/0408-FlutterMessangerDemo-Luke_Social-e8a0e8ddab86b503a125ebcad823c583.png",
      createdAt: DateTime.now(),
      messageType: MessageType.image,
      sendBy: ChatUser(
        id: '1',
        name: 'Flutter',
        profilePhoto: "https://docs.flutter.dev/assets/images/docs/catalog-widget-placeholder.png",
      ),
      reaction: '❤️',
    ),
    Message(
      id: '10',
      message: "🤩🤩",
      createdAt: DateTime.now(),
      sendBy: ChatUser(
        id: '2',
        name: 'Simform',
        profilePhoto: Data.profileImage,
      ),
    ),
  ];
}
