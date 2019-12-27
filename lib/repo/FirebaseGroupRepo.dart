import 'package:flutter/material.dart';
import 'package:myturn/models/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:myturn/core/repo/AbstractGroupRepo.dart';

class FirebaseGroupRepo implements AbstractGroupRepo {
  // get the instance of Firestore collection for "group" table
  final groupCollection = Firestore.instance.collection('group');

  FirebaseGroupRepo();
  @override
  Future<void> addGroup(Group group) async {
    // Get the Firestore document by converting the POJO to an entity to a document
    //return groupCollection.add(group.toEntity().toDocument());
    return groupCollection.add(this.toDocument(group));
  }

  @override
  Future<void> deleteGroup(Group group) {
    return groupCollection.document(group.groupId).delete();
  }

  @override
  Future<void> updateGroup(Group group) {
    return groupCollection.document(group.groupId).updateData(group.toEntity().toDocument());
  }

  /// This method converts the group object to Firestore document. Since firestore creates a unique document Id for every record,
  /// we dont have to set any explicit unique identifier for the record.
  Map<String, Object> toDocument(Group group) {
    return {'group_name': group.groupName, 'admin_id': group.adminId, 'address': group.address, 'phone_num': group.phoneNum};
  }

  /// This method converts the input Firestore document snapshot to the model object
  static Group fromDocument(DocumentSnapshot snapShot) {
    return Group(
        groupId: snapShot.documentID,
        groupName: snapShot.data['group_name'],
        adminId: snapShot.data['admin_id'],
        address: snapShot.data['address'],
        phoneNum: snapShot.data['phone_num']);
  }
}
