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
    onLeftSwipe: (message, sentBy){
        // Your code goes here
    },
    onRightSwipe: (message, sentBy){
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

14. Adding pagination.
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

15. Add image picker configuration.
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

16. Add `ChatViewState` customisations.
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

18. Callback when a user starts/stops typing in `TextFieldConfiguration`

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

19. Passing customReceipts builder or handling stuffs related receipts see `ReceiptsWidgetConfig` in  outgoingChatBubbleConfig.

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

20. Flag `enableOtherUserName` to hide user name in chat.

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
        onMoreTap: (Message message, bool sentByCurrentUser) {
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

30. Add default avatar for profile image `defaultAvatarImage`,
    error builder for asset and network profile image `assetImageErrorBuilder` `networkImageErrorBuilder`,
    Enum `ImageType` to define image as asset, network or base64 data.
```dart
ChatView(
  ...
      appBar: ChatViewAppBar(
        defaultAvatarImage: defaultAvatar,
        imageType: ImageType.network,
        networkImageErrorBuilder: (context, url, error) {
          return Center(
            child: Text('Error $error'),
          );
        },
        assetImageErrorBuilder: (context, error, stackTrace) {
          return Center(
            child: Text('Error $error'),
          );
        },
      ),
  ...
),
```

31. Added a `customMessageReplyViewBuilder` to customize reply message view for custom type message.

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

32. Added a `replyMessageBuilder` to customize view for the reply.

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

33. Reply Suggestions functionalities.

* Add reply suggestions
```dart
_chatController.addReplySuggestions([
      SuggestionItemData(text: 'Thanks.'),
      SuggestionItemData(text: 'Thank you very much.'),
      SuggestionItemData(text: 'Great.')
    ]);
```
* Remove reply suggestions
```dart
_chatController.removeReplySuggestions();
```
* Update suggestions Config
```dart
replySuggestionsConfig: ReplySuggestionsConfig(
    itemConfig: SuggestionItemConfig(
        decoration: BoxDecoration(),
        textStyle: TextStyle(),
        padding: EdgetInsets.all(8),
        customItemBuilder: (index, suggestionItemData) => Container()
    ),
    listConfig: SuggestionListConfig(
        decoration: BoxDecoration(),
        padding: EdgetInsets.all(8),
        itemSeparatorWidth: 8,
        axisAlignment: SuggestionListAlignment.left
    )
    onTap: (item) =>
        _onSendTap(item.text, const ReplyMessage(), MessageType.text),
    autoDismissOnSelection: true
),
```

34. Added callback `messageSorter` to sort message in `ChatBackgroundConfiguration`.

```dart
ChatView(
   ...
      chatBackgroundConfig: ChatBackgroundConfiguration(
      ...
        messageSorter: (message1, message2) {
          return message1.createdAt.compareTo(message2.createdAt);
        }
      ...
     ),
  ...
),
```