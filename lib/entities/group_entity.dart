import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final String groupId;
  final String groupName;
  final String adminId;
  final String address;
  final String phoneNum;

  GroupEntity(this.groupId, this.groupName, this.adminId, this.address, this.phoneNum);

  @override
  List<Object> get props => [this.groupId, this.groupName, this.adminId, this.address, this.phoneNum];

  /// This method returns the object data in the form of a JSON
  Map<String, Object> toJson() {
    return {'group_id': this.groupId, 'group_name': this.groupName, 'admin_id': this.adminId, 'address': this.address, 'phone_num': this.phoneNum};
  }

  /// This method converts the input JSON to the entity object
  static GroupEntity fromJson(Map<String, Object> json) {
    return GroupEntity(json['group_id'] as String, json['group_name'] as String, json['admin_id'] as String, json['address'] as String, json['phone_num'] as String);
  }

  /// This method converts the input Firestore document snapshot to the entity object
  static GroupEntity fromDocument(DocumentSnapshot snapShot) {
    return GroupEntity(snapShot.documentID, snapShot.data['group_name'], snapShot.data['admin_id'], snapShot.data['address'], snapShot.data['phone_num']);
  }

  /// This method converts the group object to Firestore document. Since firestore creates a unique document Id for every record,
  /// we dont have to set any explicit unique identifier for the record.
  Map<String, Object> toDocument() {
    return {'group_name': this.groupName, 'admin_id': this.adminId, 'address': this.address, 'phone_num': this.phoneNum};
  }
}
