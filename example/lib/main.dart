import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat Ui Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();
  final _backGroundImage =
      "https://images.pexels.com/photos/1591447/pexels-photo-1591447.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  final _list = [
    Message(
      id: '1',
      message: "Hi",
      createdAt: DateTime.now(),
      sendBy: "Dhvanit",
    ),
    Message(
      id: '2',
      message: "Hi",
      createdAt: DateTime.now(),
      sendBy: "Faiyaz",
    ),
    Message(
      id: '3',
      message: "How are you?",
      createdAt: DateTime.now(),
      sendBy: "Dhvanit",
    ),
    Message(
      id: '4',
      message: "I am fine",
      createdAt: DateTime.now(),
      sendBy: "Faiyaz",
    ),
    Message(
      id: '5',
      message: "Okay",
      createdAt: DateTime.now(),
      sendBy: "Dhvanit",
      reaction: '❤️',
    ),
    Message(
      id: '6',
      message: "Do you hav idea about this?",
      createdAt: DateTime.now(),
      sendBy: "Faiyaz",
    ),
    Message(
      id: '7',
      message:
          "https://docs.flutter.dev/development/packages-and-plugins/developing-packages",
      createdAt: DateTime.now(),
      sendBy: "Faiyaz",
      replyMessage: ReplyMessage(
          message: "Do you hav idea about this?", replyTo: "Faiyaz"),
    ),
    Message(
      id: '8',
      message:
          "https://images.pexels.com/photos/586744/pexels-photo-586744.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      createdAt: DateTime.now(),
      sendBy: "Dhvanit",
    ),
    Message(
      id: '9',
      message:
          "https://images.pexels.com/photos/586744/pexels-photo-586744.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      createdAt: DateTime.now(),
      sendBy: "Faiyaz",
      reaction: '❤️',
    ),
    Message(
      id: '6',
      message: "EveryThing is fine?",
      createdAt: DateTime.now(),
      sendBy: "Faiyaz",
    ),
    Message(
      id: '6',
      message: "😂😂",
      createdAt: DateTime.now(),
      sendBy: "Dhvanit",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat Ui Demo'),
      ),
      body: ChatList(
        scrollController: _scrollController,
        messageList: _list,
        currentUser: "Dhvanit",
        chatListConfiguration: ChatListConfiguration(
          height: 500,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          backgroundImage: _backGroundImage,
        ),
        chatBubbleConfiguration: ChatBubbleConfiguration(
          padding: const EdgeInsets.all(5),
          maxWidth: 220,
        ),
        outgoingChatBubble: ChatBubble(
          textStyle: const TextStyle(fontSize: 18),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        ),
        inComingChatBubble: ChatBubble(
          color: Colors.white,
          textStyle: const TextStyle(color: Colors.black),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(12)),
        ),
        textMessage: TextMessage(
          linkTextStyle: const TextStyle(color: Colors.blue),
          padding: const EdgeInsets.all(9),
        ),
        messageReaction: MessageReaction(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 4),
          margin: const EdgeInsets.only(left: 10),
          borderWidth: 1.5,
          borderRadius: BorderRadius.circular(18),
          borderColor: Colors.blue,
          size: 13,
        ),
        profileCircleConfiguration: ProfileCircleConfiguration(
          circleRadius: 20,
          bottomPadding: 0,
          senderProfileImageUrl:
              "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        ),
        imageMessage: ImageMessage(
          borderRadius: BorderRadius.circular(14),
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.all(6),
          width: 150,
          height: 200,
          onImageViewTap: () => print("On Image Tap"),
          shareIcon: ShareIconConfiguration(
            icon: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.black,
                size: 16,
              ),
            ),
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.all(8.0),
            onPressed: () => print("On share button tap"),
          ),
        ),
        emojiMessageTextStyle: const TextStyle(fontSize: 35),
        emojiMessagePadding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 5,
        ),
      ),
    );
  }
}
