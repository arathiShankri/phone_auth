import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String userName;
  final String phoneNum;

  UserEntity({this.userId, this.userName, this.phoneNum});

  @override
  // TODO: implement props
  List<Object> get props => [this.userId, this.userName, this.phoneNum];

  /// This method returns the object data in the form of a JSON
  Map<String, Object> toJson() {
    return {
      'user_id': this.userId,
      'user_name': this.userName,
      'phone_num': this.phoneNum,
    };
  }

  /// This method converts the input JSON to the entity object
  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(userId: json['user_id'] as String, userName: json['user_name'] as String, phoneNum: json['phone_num'] as String);
  }

  /// This method converts the input Firestore documenta snapshot to the entity object
  static UserEntity fromDocument(DocumentSnapshot snapShot) {
    return UserEntity(userId: snapShot.documentID, userName: snapShot.data['user_name'], phoneNum: snapShot.data['phone_num']);
  }

  /// This method converts the entity object to Firestore document. Since firestore creates a unique document Id for every record,
  /// we dont have to set any explicit unique identifier for the record.
  Map<String, Object> toDocument() {
    return {'user_name': this.userName, 'phone_num': this.phoneNum};
  }
}
