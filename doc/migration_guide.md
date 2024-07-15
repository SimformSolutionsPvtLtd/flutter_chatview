## Migration guide for release 2.0.0

- Renamed `sendBy` field to `sentBy` in `Message` class.

- Renamed `chatUsers` field to `otherUsers` in `ChatController` class.

- Moved `currentUser` field from `ChatView` widget to `ChatController` class

- Updated `id` value in `copyWith` method of `Message` to have correct value.

- Removed `showTypingIndicator` field from `ChatView` and replaced it with `ChatController.showTypingIndicator`.

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
    ```

- Updated `ChatUser`, `Message` and `ReplyMessage` Data Model's `fromJson` and `toJson` methods:

  ##### in `ChatUser.fromJson`:

  Before:
    ```dart
    ChatUser.fromJson(
      { 
        ...
        'imageType': ImageType.asset,
        ...
      },
    ),
    ```

  After:
    ```dart
    ChatUser.fromJson(
      {
        ...
        'imageType': 'asset',
        ...
      },
    ),
    ```

  ##### in `ChatUser.toJson`:

  Before:
    ```dart
    {
      ...
      imageType: ImageType.asset,
      ...
    }
    ```

  After:
    ```dart
    {
      ...
      imageType: asset,
      ...
    }
    ```

  ##### in `Message.fromJson`:

  Before:
    ```dart
    Message.fromJson(
      {
        ...
        'createdAt': DateTime.now(),
        'message_type': MessageType.text,
        'voice_message_duration': Duration(seconds: 5),
        ...
      }
    )
    ```

  After:
    ```dart
    Message.fromJson(
      {
        ...
        'createdAt': '2024-06-13T17:32:19.586412',
        'message_type': 'text',
        'voice_message_duration': '5000000',
        ...
      }
    )
    ```

  ##### in `Message.toJson`:

  Before:
    ```dart
    {
      ...
      createdAt: 2024-06-13 17:23:19.454789,
      message_type: MessageType.text,
      voice_message_duration: 0:00:05.000000,
      ...
    }
    ```

  After:
    ```dart
    {
      ...
      createdAt: 2024-06-13T17:32:19.586412,
      message_type: text,
      voice_message_duration: 5000000,
      ...
    }
    ```

  ##### in `ReplyMessage.fromJson`:

  Before:
    ```dart
    ReplyMessage.fromJson(
      {
        ...
        'message_type': MessageType.text,  
        'voiceMessageDuration': Duration(seconds: 5),
        ...
      }
    )
    ```

  After:
    ```dart
    ReplyMessage.fromJson(
      {
        ...
        'message_type': 'text',  
        'voiceMessageDuration': '5000000',
        ...
      }
    )
    ```

  in `ReplyMessage.toJson`:

  Before:
    ```dart
    {
      ...
      message_type: MessageType.text,
      voiceMessageDuration: 0:00:05.000000,
      ...
    }
    ```

  After:
    ```dart
    {
      ...
      message_type: text,
      voiceMessageDuration: 5000000,
      ...
    }
    ```