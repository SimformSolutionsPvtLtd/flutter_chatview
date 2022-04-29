![Banner](https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_chat_ui/main/preview/banner.png)

# ChatView
 [![chat_view](https://img.shields.io/pub/v/chat_view?label=chat_view)](https://pub.dev/packages/chat_view)

A Flutter package that allows you to integrate Chat View with highly customization options.

## Preview

![The example app running in iOS](https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_chat_ui/main/preview/chat_view.gif)



## Installing

1.  Add dependency to `pubspec.yaml`

```dart
dependencies:
  chat_view: <latest-version>
```
*Get the latest version in the 'Installing' tab on [pub.dev](https://pub.dev/packages/chat_view)*

2.  Import the package
```dart
import 'package:chat_view/chat_view.dart';
```
3. Adding a chat controller.
```dart
final chatController = ChatController(
  initialMessageList: messageList,
  scrollController: ScrollController(),
);
```

4. Adding a `ChatView` widget.
```dart
ChatView(
  sender: ChatUser(id: '1', name: 'Flutter'),
  receiver:ChatUser(id: '2', name: 'Simform'),
  chatController: chatController,
  onSendTap: onSendTap,
)
```

5. Adding a messageList with `Message` class.
```dart
List<Message> messageList = [
  Message(
    id: '1',
    message: "Hi",
    createdAt: createdAt,
    sendBy: userId,
  ),
  Message(
    id: '2',
    message: "Hello",
    createdAt: createdAt,
    sendBy: userId,
  ),
];
```

6. Adding a `onSendTap`.
```dart
void onSendTap(String message, ReplyMessage replyMessage){
  final message = Message(
    id: '3',
    message: "How are you",
    createdAt: DateTime.now(),
    sendBy: sender.id,
  );
  chatController.addMessage(message);
}
```

7. Sending a image url.
```dart
void onSendTap(String message, ReplyMessage replyMessage){
  final message = Message(
    id: '3',
    message: imageLink,    
    createdAt: DateTime.now(),
    sendBy: sender.id,
    messageType: MessageType.image,
  );
  chatController.addMessage(message);
}
```
## Some more optional parameters

1. Adding an appbar with `ChatViewAppBar`.
```dart
ChatView(
  appBar: ChatViewAppBar(
    profilePicture: profileImage,
    title: "Simform",
    userStatus: "online",
    actions: [
      Icon(Icons.more_vert),
    ],
  ),
)
```

2. Adding a message list configuration with `ChatBackgroundConfiguration` class.
```dart
ChatView(
   ...
   chatBackgroundConfig: ChatBackgroundConfiguration(
     backgroundColor: Colors.white,
     backgroundImage: backgroundImage,
   ),
   ...
)
```

3. Adding a send message configuration with `SendMessageConfiguration` class.
```dart
ChatView(
   ...
   sendMessageConfig: SendMessageConfiguration(
     replyMessageColor: Colors.grey,
     replyDialogColor:Colors.blue,
     replyTitleColor: Colors.black,
     closeIconColor: Colors.black,
     horizontalDragToShowMessageTime: true, // to show message created time
   ),
   ...
)
```

4. Adding a receiver's profile image.
```dart
ChatView(
   ...
   showReceiverProfileCircle: true,
   profileCircleConfig: ProfileCircleConfiguration(profileImageUrl: profileImage),
   /// Add profileImage url of recevier
   ...
)
``` 

5. Adding a chat bubble configuration with `ChatBubbleConfiguration` class.
```dart
ChatView(
   ...
   chatBubbleConfig: ChatBubbleConfiguration(
     onDoubleTap: (){
       // Your code goes here
     },
     outgoingChatBubbleConfig: ChatBubble(      // Sender's message chat bubble 
       color: Colors.blue,
       borderRadius: const BorderRadius.only(  
         topRight: Radius.circular(12),
         topLeft: Radius.circular(12),
         bottomLeft: Radius.circular(12),
       ),
     ),
     inComingChatBubbleConfig: ChatBubble(      // Receiver's message chat bubble
       color: Colors.grey.shade200,
       borderRadius: const BorderRadius.only(
         topLeft: Radius.circular(12),
         topRight: Radius.circular(12),
         bottomRight: Radius.circular(12),
       ),
     ),
   )
   ...
)
```

6. Adding swipe to reply configuration with `SwipeToReplyConfiguration` class.
```dart
ChatView(
   ...
   swipeToReplyConfig: SwipeToReplyConfiguration(
     onLeftSwipe: (message, sendBy){
        // Your code goes here
     },
     onRightSwipe: (message, sendBy){
        // Your code goes here
     },              
   ),
   ...
)
```

7. Adding messages configuration with `MessageConfiguration` class.
```dart
ChatView(
   ...
   messageConfig: MessageConfiguration(
     messageReactionConfig: MessageReactionConfiguration(),      // Emoji reaction configuration for single message 
     imageMessageConfig: ImageMessageConfiguration(
       onTap: (){
          // Your code goes here
       },                          
       shareIconConfig: ShareIconConfiguration(
         onPressed: (){
           // Your code goes here
         },
       ),
     ),
   ),
   ...
)
```

8. Adding reaction pop-up configuration with `ReactionPopupConfiguration` class.
```dart
ChatView(
   ...
   reactionPopupConfig: ReactionPopupConfiguration(
     backgroundColor: Colors.white,
     onEmojiTap: (emoji, messageId){
       chatController.setReaction(emoji,messageId);
     },
   ),
   ...
)
```

9. Adding reply pop-up configuration with `ReplyPopupConfiguration` class.
```dart
ChatView(
   ...
   replyPopupConfig: ReplyPopupConfiguration(
     backgroundColor: Colors.white,
     onUnsendTap:(message){                   // message is 'Message' class instance
       // Your code goes here
     },
     onReplyTap:(message){                    // message is 'Message' class instance
       // Your code goes here
     },
     onReportTap:(){
       // Your code goes here
     },
     onMoreTap:(){
       // Your code goes here
     },
   ),
   ...
)
```

10. Adding replied message configuration with `RepliedMessageConfiguration` class.
```dart
ChatView(
   ...
   repliedMessageConfig: RepliedMessageConfiguration(
     backgroundColor: Colors.blue,
     verticalBarColor: Colors.black,
   ),
   ...
)
```

11. Show typing indicator and adding configuration.
```dart
ChatView(
   ...
   showTypingIndicator: true, // To show idicator when receiver satrted typing
   typeIndicatorConfig: TypeIndicatorConfiguration(
     flashingCircleBrightColor: Colors.grey,
     flashingCircleDarkColor: Colors.black,
   ),
   ...
)
```

12. Adding linkpreview configuration with `LinkPreviewConfiguration` class.
```dart
ChatView(
   ...
   chatBubbleConfig: ChatBubbleConfiguration(
     linkPreviewConfig: LinkPreviewConfiguration(
       linkStyle: const TextStyle(
         color: Colors.white,
         decoration: TextDecoration.underline,
       ),
       backgroundColor: Colors.grey,
       bodyStyle: const TextStyle(
         color: Colors.grey.shade200,
         fontSize:16,
       ),
       titleStyle: const TextStyle(
         color: Colors.black,
         fontSize:20,
       ),
     ),
   )
   ...
)
```

13. Adding pagination.
```dart
ChatView(
   ...
   isLastPage: false,
   enablePagination: true,
   loadMoreData: chatController.loadMoreData,
   ...
)
```

## How to use

Check out the **example** app in the [example](example) directory or the 'Example' tab on pub.dartlang.org for a more complete example.


## Main Contributors

<table>
  <tr>
    <td align="center"><a href="https://github.com/vatsaltanna"><img src="https://avatars.githubusercontent.com/u/25323183?s=100" width="100px;" alt=""/><br /><sub><b>Vatsal Tanna</b></sub></a></td>
    <td align="center"><a href="https://github.com/DhvanitVaghani"><img src="https://avatars.githubusercontent.com/u/64645989?v=4" width="100px;" alt=""/><br /><sub><b>Dhvanit Vaghani</b></sub></a></td>
  </tr>
</table>
<br/>

## License

```text
MIT License
Copyright (c) 2022 Simform Solutions
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```