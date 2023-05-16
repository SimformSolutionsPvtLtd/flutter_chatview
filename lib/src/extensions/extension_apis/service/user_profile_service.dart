import '../../../models/models.dart';

abstract class ProfileManager {
  const ProfileManager();

  Future<ChatUser?> fetchChatUser(String id);

  Future<List<ChatUser?>> fetchChatUsers(String roomId);

  void createChatUsers(Room room);
}
