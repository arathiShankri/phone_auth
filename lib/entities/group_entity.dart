import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final String groupId;
  final String groupName;
  final String adminId;
  final String address;

  GroupEntity(this.groupId, this.groupName, this.adminId, this.address);

  @override
  // TODO: implement props
  List<Object> get props => [this.groupId, this.groupName, this.adminId, this.address];

  /// This method returns the object data in the form of a JSON
  Map<String, Object> toJson() {
    return {'groupId': this.groupId, 'groupName': this.groupName, 'adminId': this.adminId, 'address': this.address};
  }

  /// This method converts the input JSON to the entity object
  static GroupEntity fromJson(Map<String, Object> json) {
    return GroupEntity(json['groupId'] as String, json['groupName'] as String, json['adminId'] as String, json['address'] as String);
  }

  /// This method converts the input Firestore document snapshot to the entity object
  static GroupEntity fromDocument(DocumentSnapshot snapShot) {
    return GroupEntity(snapShot.documentID, snapShot.data['group_name'], snapShot.data['admin'], snapShot.data['address']);
  }

  /// This method converts the group object to Firestore document. Since firestore creates a unique document Id for every record,
  /// we dont have to set any explicit unique identifier for the record.
  Map<String, Object> toDocument() {
    return {'groupId': this.groupId, 'groupName': this.groupName, 'adminId': this.adminId, 'address': this.address};
  }
}
