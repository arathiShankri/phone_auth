import 'package:equatable/equatable.dart';
import 'package:myturn/entities/entities.dart';

class Group extends Equatable {
  String groupId;
  String groupName;
  String adminId;
  String address;
  String phoneNum;

  Group({this.groupId, this.groupName, this.adminId, this.address, this.phoneNum});

  @override
  // instead of doing super for equatable, we are doing this.
  List<Object> get props => [this.groupId, this.groupName, this.adminId, this.address, this.phoneNum];

  /// toEntity - This method converts the User POJO to an entity object
  /// The entity class has further methods to convert the POJO to datastore related objects
  GroupEntity toEntity() {
    return GroupEntity(this.groupId, this.groupName, this.adminId, this.address, this.phoneNum);
  }

  /// fromEntity - This method creates the POJO back from the entity object
  static Group fromEntity(GroupEntity entity) {
    return Group(groupId: entity.groupId, groupName: entity.groupName, adminId: entity.adminId, address: entity.address, phoneNum: entity.phoneNum);
  }
}
