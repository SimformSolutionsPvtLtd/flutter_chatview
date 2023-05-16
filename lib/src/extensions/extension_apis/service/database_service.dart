import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../chatview.dart';
part 'database_service.g.dart';

/// `DatabaseManager` adds capability to store and retrieve messages
/// in [ChatView] directly, it holds
/// 1. `ProfileManager`
/// 2. `RoomManager`
/// ### ProfileManager
/// The `ProfileManager` class provides CRUD operations for managing `ChatUser` profiles and their attributes.
///
/// It allows creating new profiles, retrieving existing profiles, updating profile information,
/// and deleting profiles from the database see see [ProfileManager].
///
/// ### RoomManager
/// The `RoomManager` class provides CRUD operations for managing rooms.
///
/// It allows creating new rooms, retrieving existing rooms,
/// updating room information, and deleting rooms from the database see [RoomManager]
///
/// ```dart
///    class MyCustomDatabaseManager extends DatabaseManager {
///   MyCustomDatabaseManager(this.currentUser) : super(currentUser: currentUser);
///
///   final ChatUser currentUser;
///
///   @override
///   void init() {
///     // Have you init Method
///  }
///  @override
///   // Your profile manager instance here
///   ProfileManager get profileManager => const MyProfileManager(currentUser);
///   @override
///  /// Your room manager instance here.
///   RoomManager get roomManager => const MyRoomManager();
/// }
/// ```
abstract class DatabaseManager<T extends ProfileManager,
    E extends RoomManager> {
  DatabaseManager({required this.currentUser}) {
    init();
  }

  T get profileManager;

  E get roomManager;

  final ChatUser currentUser;

  @mustCallSuper
  @protected
  void init();
}

@JsonSerializable()
class UpdatedReceipt {
  const UpdatedReceipt({required this.id, required this.newStatus});

  final String id;
  final MessageStatus newStatus;

  Map<String, dynamic> toJson() => _$UpdatedReceiptToJson(this);

  factory UpdatedReceipt.fromJson(Map<String, dynamic> json) =>
      _$UpdatedReceiptFromJson(json);
}
