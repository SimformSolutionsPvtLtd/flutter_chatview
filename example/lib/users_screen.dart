import 'package:chatview/chatview.dart';
import 'package:example/service_locator.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late ValueNotifier<List<ChatUser>> _userListNotifier;

  SqfliteUserProfileService? get _userProfileService => serviceLocator
      .get<ChatViewController>()
      .chatViewExtension
      ?.serviceExtension
      ?.dataBaseService
      ?.userProfileService as SqfliteUserProfileService;

  SqfLiteChatRoomDataBaseService? get _chatroomService => serviceLocator
      .get<ChatViewController>()
      .chatViewExtension
      ?.serviceExtension
      ?.dataBaseService
      ?.chatRoomDataBaseService as SqfLiteChatRoomDataBaseService;

  ChatUser get _currentUser =>
      serviceLocator.get<ChatViewController>().currentUser;

  @override
  void initState() {
    super.initState();
    _userListNotifier = ValueNotifier<List<ChatUser>>([]);
    init();
  }

  Future<void> init() async {
    List<ChatUser> fetchedUsers = await _userProfileService?.fetchUsers() ??
        []; // Replace fetchUserList with your actual function to fetch user list
    _userListNotifier.value = fetchedUsers;
  }

  @override
  void dispose() {
    _userListNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: ValueListenableBuilder<List<ChatUser>>(
        valueListenable: _userListNotifier,
        builder: (context, userList, _) {
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              ChatUser user = userList[index];
              return ListTile(
                leading: CircleAvatar(
                  child:
                      Text(user.firstName != null ? user.firstName! : user.id),
                ),
                title: Text('${user.firstName} ${user.lastName}'),
                subtitle: Text(user.role.toString()),
                onTap: () {
                  _chatroomService?.createRoom(Room(
                    id: directRoomIdProvider(user.id, _currentUser.id),
                    type: RoomType.direct,
                    createdAt: DateTime.now().millisecondsSinceEpoch,
                    users: [user, _currentUser],
                  ));
                  // Handle user tile tap (e.g., navigate to user details screen)
                  // ...
                },
              );
            },
          );
        },
      ),
    );
  }
}
