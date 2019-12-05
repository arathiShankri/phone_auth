import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ScheduleEntity extends Equatable {
  final String userId;
  final String userName;
  final String createdAt;
  final String slotTime;

  ScheduleEntity(this.userId, this.userName, this.slotTime, this.createdAt);

  /// This method converts the existing entity object to JSON
  Map<String, Object> toJson() {
    return {'userId': this.userId, 'userName': this.userName, 'slotTime': this.slotTime, 'createdAt': this.createdAt};
  }

  /// This method converts the input JSON to entity object
  ScheduleEntity fromJson(Map<String, Object> json) {
    return ScheduleEntity(json['userID'] as String, json['userName'] as String, json['slotTime'] as String, json['createdAt'] as String);
  }

  /// This method converts the entity object to Firestore document snap shot
  Map<String, Object> toDocument() {
    return {'userName': this.userName, 'slotTime': this.slotTime, 'createdAt': this.createdAt};
  }

  /// This method converts the input document snapshot to entity object
  ScheduleEntity fromDocument(DocumentSnapshot snapshot) {
    return ScheduleEntity(snapshot.documentID, snapshot.data['userName'], snapshot.data['slotTime'], snapshot.data['createdAt']);
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}
