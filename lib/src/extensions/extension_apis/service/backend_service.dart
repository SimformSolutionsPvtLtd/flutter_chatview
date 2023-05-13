import 'package:chatview/src/models/models.dart';

abstract class BackendManager {
  void sendMessage(Message message);

  void listenMessages(Function(Message) callback);

  void blockUser(ChatUser user);

  void deleteMessage(Message message);

  void sendAudio(AudioMessage audioFilePath);

  void updateMessage(Message updatedMessage);
}
