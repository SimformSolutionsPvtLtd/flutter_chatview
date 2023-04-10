import '../../models.dart';

abstract class UserProfileService {
  const UserProfileService();

  Future<ChatUser?> fetchChatUser(String id);

  Future<List<ChatUser?>> fetchChatUsers(List<String> userIds);
}
