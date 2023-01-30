![Banner](https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_chat_ui/main/preview/banner.png)

# ChatView
 [![chatview](https://img.shields.io/pub/v/chatview?label=chatview)](https://pub.dev/packages/chatview)

A Flutter package that allows you to integrate Chat View with highly customization options such as one on one
chat, group chat, message reactions, reply messages, link preview and configurations for overall view.

For web demo
visit [Chat View Example](https://chat-view-8f1b5.web.app/#/).

## Preview

![The example app running in iOS](https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_chat_ui/main/preview/chatview.gif)

## Installing   

1.  Add dependency to `pubspec.yaml`

```dart
dependencies:
  chatview: <latest-version>
```
*Get the latest version in the 'Installing' tab on [pub.dev](https://pub.dev/packages/chatview)*

2.  Import the package
```dart
import 'package:chatview/chatview.dart';
```
3. Adding a chat controller.
```dart
final chatController = ChatController(
  initialMessageList: messageList,
  scrollController: ScrollController(),
  chatUsers: [ChatUser(id: '2', name: 'Simform')],
);
```

4. Adding a `ChatView` widget.
```dart
ChatView(
  currentUser: ChatUser(id: '1', name: 'Flutter'),
  chatController: chatController,
  onSendTap: onSendTap,
  chatViewState: ChatViewState.hasMessages, // Add this state once data is available.
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
    sendBy: currentUser.id,
    replyMessage: replyMessage,
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
    sendBy: currentUser.id,
    messageType: MessageType.image,
    replyMessage: replyMessage,
  );
  chatController.addMessage(message);
}
```

8. Sending voice message.
```dart
void onRecordingComplete(String audioPath, ReplyMessage replyMessage){
  final message = Message(
    id: '3',
    message: audioPath,    
    createdAt: DateTime.now(),
    sendBy: currentUser.id,
    messageType: MessageType.voice,
    replyMessage: replyMessage,
  );
  chatController.addMessage(message);
}
```
Note: This function needs to pass in `onRecordingComplete` parameter in `ChatView` class.

Note: Right now voice messages only supported for android and iOS. 

## Platform specific configuration for image picker

### iOS
Add the following keys to your _Info.plist_ file, located in `<project root>/ios/Runner/Info.plist`:

* `NSPhotoLibraryUsageDescription` - describe why your app needs permission for the photo library. This is called _Privacy - Photo Library Usage Description_ in the visual editor.
* `NSCameraUsageDescription` - describe why your app needs access to the camera. This is called _Privacy - Camera Usage Description_ in the visual editor.
* `NSMicrophoneUsageDescription` - describe why your app needs access to the microphone, if you intend to record videos. This is called _Privacy - Microphone Usage Description_ in the visual editor.


## Some more optional parameters

1. Enable and disable specific features with `FeatureActiveConfig`.
```dart
ChatView(
  ...
  featureActiveConfig: FeatureActiveConfig(
    enableSwipeToReply: true,
    enableSwipeToSeeTime: false,
  ),
  ...
)
```

2. Adding an appbar with `ChatViewAppBar`.
```dart
ChatView(
  ...
  appBar: ChatViewAppBar(
    profilePicture: profileImage,
    chatTitle: "Simform",
    userStatus: "online",
    actions: [
      Icon(Icons.more_vert),
    ],
  ),
  ...
)
```

3. Adding a message list configuration with `ChatBackgroundConfiguration` class.
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

4. Adding a send message configuration with `SendMessageConfiguration` class.
```dart
ChatView(
  ...
  sendMessageConfig: SendMessageConfiguration(
    replyMessageColor: Colors.grey,
    replyDialogColor:Colors.blue,
    replyTitleColor: Colors.black,
    closeIconColor: Colors.black,
  ),
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
    padding: EdgeInsets.all(12),
    shadow: BoxShadow(
      color: Colors.black54,
      blurRadius: 20,
    ),
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
     repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(),
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
  featureActiveConfig: FeatureActiveConfig(
    enablePagination: true,
  ),
  loadMoreData: chatController.loadMoreData,
  ...
)
```

14. Get imagepath from image picker and add imagepicker icon configuration.
```dart
ChatView(
  ...
  sendMessageConfig: SendMessageConfiguration(
    imagePickerIconsConfig: ImagePickerIconsConfiguration(
      onImageSelected: (imagePath, error){

      },
      cameraIconColor: Colors.black,
      galleryIconColor: Colors.black,
    )
  )
  ...
)
```

15. Add `ChatViewState` customisations.
```dart
ChatView(
  ...
  chatViewStateConfig: ChatViewStateConfiguration(
    loadingWidgetConfig: ChatViewStateWidgetConfiguration(
      loadingIndicatorColor: Colors.pink,
    ),
    onReloadButtonTap: () {},
  ),
  ...
)
```

16. Setting auto scroll and highlight config with `RepliedMsgAutoScrollConfig` class.
```dart
ChatView(
    ...
    repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
      enableHighlightRepliedMsg: true,
      highlightColor: Colors.grey,
      highlightScale: 1.1,
    )
    ...
)
```

17. Setting auto scroll and highlight config with `RepliedMsgAutoScrollConfig` class.
```dart
ChatView(
    ...
    repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
      enableHighlightRepliedMsg: true,
      highlightColor: Colors.grey,
      highlightScale: 1.1,
    )
    ...
)
```
## How to use

Check out the **example** app in the [example](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/tree/main/example) directory or the 'Example' tab on pub.dartlang.org for a more complete example.


## Main Contributors

<table>
  <tr>
    <td align="center"><a href="https://github.com/vatsaltanna"><img src="https://avatars.githubusercontent.com/u/25323183?s=100" width="100px;" alt=""/><br /><sub><b>Vatsal Tanna</b></sub></a></td>
    <td align="center"><a href="https://github.com/DhvanitVaghani"><img src="https://avatars.githubusercontent.com/u/64645989?v=4" width="100px;" alt=""/><br /><sub><b>Dhvanit Vaghani</b></sub></a></td>
    <td align="center"><a href="https://github.com/Ujas-Majithiya"><img src="https://avatars.githubusercontent.com/u/56400956?v=4" width="100px;" alt=""/><br /><sub><b>Ujas Majithiya</b></sub></a></td>
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