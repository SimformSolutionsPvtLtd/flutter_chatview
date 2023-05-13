import '../../../models/models.dart';

abstract class UserProfileService {
  const UserProfileService();

  Future<ChatUser?> fetchChatUser(String id);

  Future<List<ChatUser?>> fetchChatUsers(String roomId);

  void createChatUsers(Room room);
}
