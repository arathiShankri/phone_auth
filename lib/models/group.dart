import 'package:equatable/equatable.dart';
import 'package:myturn/entities/entities.dart';

class Group extends Equatable {
  final String groupId;
  final String groupName;
  final String adminId;
  final String address;

  Group({this.groupId, this.groupName, this.adminId, this.address});

  @override
  // instead of doing super for equatable, we are doing this.
  List<Object> get props => [this.groupId, this.groupName, this.adminId, this.address];

  /// toEntity - This method converts the User POJO to an entity object
  /// The entity class has further methods to convert the POJO to datastore related objects
  GroupEntity toEntity() {
    return GroupEntity(this.groupId, this.groupName, this.adminId, this.address);
  }

  /// fromEntity - This method creates the POJO back from the entity object
  static Group fromEntity(GroupEntity entity) {
    return Group(groupId: entity.groupId, groupName: entity.groupName, adminId: entity.adminId, address: entity.address);
  }
}
