1. Adding a chat controller.
```dart
final chatController = ChatController(
  initialMessageList: messageList,
  scrollController: ScrollController(),
  currentUser: ChatUser(id: '1', name: 'Flutter'),
  otherUsers: [ChatUser(id: '2', name: 'Simform')],
);
```

2. Adding a `ChatView` widget.
```dart
ChatView(
  chatController: chatController,
  onSendTap: onSendTap,
  chatViewState: ChatViewState.hasMessages, // Add this state once data is available.
)
```

3. Adding a messageList with `Message` class.
```dart
List<Message> messageList = [
  Message(
    id: '1',
    message: "Hi",
    createdAt: createdAt,
    sentBy: userId,
  ),
  Message(
    id: '2',
    message: "Hello",
    createdAt: createdAt,
    sentBy: userId,
  ),
];
```

4. Adding a `onSendTap`.
```dart
void onSendTap(String message, ReplyMessage replyMessage, MessageType messageType){
  final message = Message(
    id: '3',
    message: "How are you",
    createdAt: DateTime.now(),
    senBy: currentUser.id,
    replyMessage: replyMessage,
    messageType: messageType,
  );
  chatController.addMessage(message);
}
```