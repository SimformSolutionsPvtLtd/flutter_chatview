import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../chatview.dart';
part 'database_service.g.dart';


/// # DataBaseService
/// `DataBaseService`
abstract class DataBaseService<T extends UserProfileService,
    E extends ChatRoomDataBaseService> {
  DataBaseService({required this.currentUser}) {
    init();
  }

  T get userProfileService;

  E get chatRoomDataBaseService;

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
