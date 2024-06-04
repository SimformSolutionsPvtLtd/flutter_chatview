![Banner](https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_chat_ui/main/preview/banner.png)

# ChatView
 [![chatview](https://img.shields.io/pub/v/chatview?label=chatview)](https://pub.dev/packages/chatview)

A Flutter package that allows you to integrate Chat View with highly customization options such as one on one
chat, group chat, message reactions, reply messages, link preview and configurations for overall view.

For web demo
visit [Chat View Example](https://chat-view-8f1b5.web.app/#/).

## Preview

![The example app running in iOS](https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_chat_ui/main/preview/chatview.gif)

## Migration guide for release 2.0.0
Removed `showTypingIndicator` field from `ChatView` and replaced it with `ChatController.showTypingIndicator`.

Before:
```dart
ChatView(
  showTypingIndicator:false,
),
```

After:
```dart
/// use it with your [ChatController] instance.
_chatContoller.setTypingIndicator = true; // for showing indicator
_chatContoller.setTypingIndicator = false; // for hiding indicator

ChatView(
  chatController: _chatController,
),
```

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
void onSendTap(String message, ReplyMessage replyMessage, MessageType messageType){
  final message = Message(
    id: '3',
    message: "How are you",
    createdAt: DateTime.now(),
    sendBy: currentUser.id,
    replyMessage: replyMessage,
    messageType: messageType,
  );
  chatController.addMessage(message);
}
```

Note: you can evaluate message type from `messageType` parameter, based on that you can perform operations.

## Messages types compability

|Message Types   | Android | iOS | MacOS | Web | Linux | Windows |
| :-----:        | :-----: | :-: | :---: | :-: | :---: | :-----: |
|Text messages   |   ✔️    | ✔️  |  ✔️   | ✔️  |  ✔️   |   ✔️    |
|Image messages  |   ✔️    | ✔️  |  ✔️   | ✔️  |  ✔️   |   ✔️    |
|Voice messages  |   ✔️    | ✔️  |  ❌   | ❌  |  ❌  |   ❌  |
|Custom messages |   ✔️    | ✔️  |  ✔️   | ✔️  |  ✔️   |   ✔️    |


## Platform specific configuration

### For image Picker
#### iOS
* Add the following keys to your _Info.plist_ file, located in `<project root>/ios/Runner/Info.plist`:

```
    <key>NSCameraUsageDescription</key>
    <string>Used to demonstrate image picker plugin</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>Used to capture audio for image picker plugin</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>Used to demonstrate image picker plugin</string>
```

### For voice messages
#### iOS
* Add this two rows in `ios/Runner/Info.plist`
```
    <key>NSMicrophoneUsageDescription</key>
    <string>This app requires Mic permission.</string>
```
* This plugin requires ios 10.0 or higher. So add this line in `Podfile`
```
    platform :ios, '10.0'
```

#### Android
* Change the minimum Android sdk version to 21 (or higher) in your android/app/build.gradle file.
```
    minSdkVersion 21
```

* Add RECORD_AUDIO permission in `AndroidManifest.xml`
```
    <uses-permission android:name="android.permission.RECORD_AUDIO"/>
```


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
    userReactionCallback: (message, emoji){
      // Your code goes here
    }
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

11. For customizing typing indicators use `typeIndicatorConfig` with `TypeIndicatorConfig`.
```dart
ChatView(
  ...

  typeIndicatorConfig: TypeIndicatorConfiguration(
    flashingCircleBrightColor: Colors.grey,
    flashingCircleDarkColor: Colors.black,
  ),
  ...
)
```
12. For showing hiding typeIndicatorwidget use `ChatController.setTypingIndicaor`, for more info see `ChatController`.
```dart
/// use it with your [ChatController] instance.
_chatContoller.setTypingIndicator = true; // for showing indicator
_chatContoller.setTypingIndicator = false; // for hiding indicator
```




13. Adding linkpreview configuration with `LinkPreviewConfiguration` class.
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

14. Add image picker configuration.
```dart
ChatView(
  ...
  sendMessageConfig: SendMessageConfiguration(
    enableCameraImagePicker: false,
    enableGalleryImagePicker: true,
    imagePickerIconsConfig: ImagePickerIconsConfiguration(
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

17.  Callback when a user starts/stops typing in `TextFieldConfiguration`
    
```dart
ChatView(
    ...
      sendMessageConfig: SendMessageConfiguration(
       
          textFieldConfig: TextFieldConfiguration(
            onMessageTyping: (status) {
                // send composing/composed status to other client
                // your code goes here
            },   

            
        /// After typing stopped, the threshold time after which the composing
        /// status to be changed to [TypeWriterStatus.typed].
        /// Default is 1 second.
            compositionThresholdTime: const Duration(seconds: 1),

        ),
    ...
  )
)
```

18.  Passing customReceipts builder or handling stuffs related receipts see `ReceiptsWidgetConfig` in  outgoingChatBubbleConfig.
    
```dart
ChatView(
   ...
      featureActiveConfig: const FeatureActiveConfig(
            /// Controls the visibility of message seen ago receipts default is true
            lastSeenAgoBuilderVisibility: false,
            /// Controls the visibility of the message [receiptsBuilder]
            receiptsBuilderVisibility: false),            
       ChatBubbleConfiguration(
          inComingChatBubbleConfig: ChatBubble(
            onMessageRead: (message) {
              /// send your message reciepts to the other client
              debugPrint('Message Read');
            },

          ),
          outgoingChatBubbleConfig: ChatBubble(
              receiptsWidgetConfig: ReceiptsWidgetConfig(
                      /// custom receipts builder 
                      receiptsBuilder: _customReceiptsBuilder,
                      /// whether to display receipts in all 
                      /// message or just at the last one just like instagram
                      showReceiptsIn: ShowReceiptsIn.lastMessage
              ),
            ), 
        ), 
        
  ...
 
)
```

19. Added field `chatTextFieldTopPadding` to set top padding of chat text field.

```dart
ChatView(
   ...
      chatTextFieldTopPadding: 10,
  ...
 
)
```

20.  Flag `enableOtherUserName` to hide user name in chat.

```dart
ChatView(
   ...
      featureActiveConfig: const FeatureActiveConfig(
        enableOtherUserName: false,
      ),
   ...

)
```

21. Added report button for receiver message and update `onMoreTap` and `onReportTap` callbacks.

```dart
ChatView(
   ...
      replyPopupConfig: ReplyPopupConfiguration(
        onReportTap: (Message message) {
          debugPrint('Message: $message');
        },
        onMoreTap: (Message message, bool sendByCurrentUser) {
          debugPrint('Message : $message');
        },
      ),
   ...
)
```

22. Added `emojiPickerSheetConfig` for configuration of emoji picker sheet.

```dart
ChatView(
   ...
      emojiPickerSheetConfig: Config(
        emojiViewConfig: EmojiViewConfig(
          columns: 7,
          emojiSizeMax: 32,
          recentsLimit: 28,
          backgroundColor: Colors.white,
        ),
        categoryViewConfig: const CategoryViewConfig(
          initCategory: Category.RECENT,
          recentTabBehavior: RecentTabBehavior.NONE,
        ),
  ...
 
)
```

23. Configure the styling & audio recording quality using `VoiceRecordingConfiguration` in sendMessageConfig.

```dart
ChatView(
    ...
      sendMessageConfig: SendMessageConfiguration(

            voiceRecordingConfiguration: VoiceRecordingConfiguration(
            iosEncoder: IosEncoder.kAudioFormatMPEG4AAC,
            androidOutputFormat: AndroidOutputFormat.mpeg4,
            androidEncoder: AndroidEncoder.aac, 
            bitRate: 128000,
            sampleRate: 44100,
            waveStyle: WaveStyle(
                showMiddleLine: false,
                waveColor: theme.waveColor ?? Colors.white,
                extendWaveform: true,
            ),
        ),
    
    ...
  )
)
```

24. Added `enabled` to enable/disable chat text field.

```dart
ChatView(
   ...
      sendMessageConfig: SendMessageConfiguration(
      ...
        textFieldConfig: TextFieldConfig(
          enabled: true // [false] to disable text field.
        ),
      ...
      ),
  ...
 
)
```
25. Added flag `isProfilePhotoInBase64` that defines whether provided image is url or base64 data.

```dart
final chatController = ChatController(
  ...
    chatUsers: [
      ChatUser(
        id: '1',
        name: 'Simform',
        isProfilePhotoInBase64: false,
        profilePhoto: 'ImageNetworkUrl',
      ),
    ],
  ...
);

ChatView(
   ...
      profileCircleConfig: const ProfileCircleConfiguration(
        isProfilePhotoInBase64: false,
        profileImageUrl: 'ImageNetworkUrl',
      ),
   ...
)
```

26. Added `chatSeparatorDatePattern` in `DefaultGroupSeparatorConfiguration` to separate chats with provided pattern.

```dart
ChatView(
    ...
      chatBackgroundConfig: ChatBackgroundConfiguration(
        ...
          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
            chatSeparatorDatePattern: 'MMM dd, yyyy'
          ),
        ...
      ),
    ...
)
```

27. Field `cancelRecordConfiguration` to provide an configuration to cancel voice record message.

```dart
ChatView(
   ...
      sendMessageConfig: SendMessageConfiguration(
        ...
           cancelRecordConfiguration: CancelRecordConfiguration(
            icon: const Icon(
              Icons.cancel_outlined,
            ),
            onCancel: () {
              debugPrint('Voice recording cancelled');
            },
            iconColor: Colors.black,
           ),
        ...
      ),
   ...

)
```

28. Added callback of onTap on list of reacted users in reaction sheet `reactedUserCallback`.
```dart

ChatView(
   ...
      messageConfig: MessageConfiguration(
      ...
        messageReactionConfig: MessageReactionConfiguration(
          reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
            reactedUserCallback: (reactedUser, reaction) {
              debugPrint(reaction);
            },
          ),
        ),
      ...
      ),
  ...
),
```

29. Added a `customMessageReplyViewBuilder` to customize reply message view for custom type message.

```dart
ChatView(
  ...
    messageConfig: MessageConfiguration(
      customMessageBuilder: (ReplyMessage state) {
        return Text(
        state.message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          ),
        );
      },
    ),
  ...
)
```

30. Added a `replyMessageBuilder` to customize view for the reply.

```dart
ChatView(
  ...
    replyMessageBuilder: (context, state) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(14),
          ),
        ),
        margin: const EdgeInsets.only(
          bottom: 17,
          right: 0.4,
          left: 0.4,
        ),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text( 
                        state.message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.close,
                        size: 16,
                      ),
                      onPressed: () => ChatView.closeReplyMessageView(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
    },
  ...
)
```



## How to use

Check out [blog](https://medium.com/simform-engineering/chatview-a-cutting-edge-chat-ui-solution-7367b1f9d772) for better understanding and basic implementation. 

Also, for whole example, check out the **example** app in the [example](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/tree/main/example) directory or the 'Example' tab on pub.dartlang.org for a more complete example.


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
