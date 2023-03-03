## (UnReleased)

* **Fix**: [60](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/60) Fix image from
  file is not loaded.
* **Fix**: [61](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/61) Fix issue of
  audio message is not working.


## [1.2.0+1]

* **Feat**: [42](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/42) Ability to 
  get callback on tap of profile circle avatar.
* **Breaking**: Add `messageType` in `onSendTap` callback for encountering messages.
* **Breaking**: Remove `onRecordingComplete` and you can get Recorded audio in `onSendTap` callback
  with `messageType`.
* **Breaking**: Remove `onImageSelected` from `ImagePickerIconsConfiguration` and can get selected
  image in `onSendTap` callback with `messageType`.
* **Feat**: [49](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/49) Add `onUrlDetect`
  callback for opening urls.
* **Feat**: [51](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/51) Ability to
  get callback on long press of profile circle avatar.

## [1.1.0]

* **Feat**: [37](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/37) Ability to 
  enable or disable specific features.
* **Feat**: [34](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/34) Ability to
  add voice message.
* **Breaking**: Remove `onEmojiTap` from `ReactionPopupConfiguration`, it can be handled internally.
* **Breaking**: Remove `horizontalDragToShowMessageTime` from `ChatBackgroundConfiguration` and 
  add `enableSwipeToSeeTime` parameter with same feature in `FeatureActiveConfig`.
* **Breaking**: Remove `showReceiverProfileCircle` and add `enableOtherUserProfileAvatar` parameter
  with same feature in `FeatureActiveConfig`.
* * **Breaking**: Move `enablePagination` parameter from `ChatView` to `FeatureActiveConfig`.

## [1.0.1]

* **Fix**: [32](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/32) Fix issue of 
  while replying to image it highlights the link instead of the image.
* **Fix**: [35](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/35) Fix issue of 
  removing reaction which is reacted accidentally.

## [1.0.0+1]

* **Breaking**: Remove `sender` and `receiver` from `ChatView`.
* **Breaking**: Add `currentUser` to chat view, which represent the sender.
* **Breaking**: Replace `title` and `titleTextStyle` with `chatTitle` and `chatTitleTextStyle`
  respectively in `ChatViewAppBar`
* **Breaking**: Add `profilePhoto` in `ChatUser` to show profile picture of sender.
* **Breaking**: Add `chatUsers` in `ChatController`.
* **Breaking**: Add `chatViewState` in `ChatView`.
* **Breaking**: Change type of `reaction` to `Reaction` in `Message`.
* [#8](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/8) Implement loading, error
  and no message UIs.
* [#13](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/13) Implement group chat
  and multiple reaction support.
* [#22](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/22) Add `TextInputType`
  for `TextField`.
* [#24](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/24)
  Add `MessageType.custom` for custom messages.
* **FEAT**: Auto scroll to replied message.

## [0.0.3]

* [#7](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/7) Add
  image-picker.

## [0.0.2]

* Fixed [#10](https://github.com/SimformSolutionsPvtLtd/flutter_chatview/issues/10) - emoji and
  text.

## [0.0.1]

* Initial release.


