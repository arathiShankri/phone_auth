import 'package:myturn/models/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:myturn/core/repo/AbstractGroupRepo.dart';

class FirebaseGroupRepo implements AbstractGroupRepo {
  // get the instance of Firestore collection for "group" table
  final groupCollection = Firestore.instance.collection('group');

  @override
  Future<void> addGroup(Group group) {
    // Get the Firestore document by converting the POJO to an entity to a document
    return groupCollection.add(group.toEntity().toDocument());
  }

  @override
  Future<void> deleteGroup(Group group) {
    return groupCollection.document(group.groupId).delete();
  }

  @override
  Future<void> updateGroup(Group group) {
    return groupCollection.document(group.groupId).updateData(group.toEntity().toDocument());
  }
}
