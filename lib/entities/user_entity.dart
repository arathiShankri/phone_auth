import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String userName;
  final String phoneNum;

  UserEntity(this.userId, this.userName, this.phoneNum);

  @override
  // TODO: implement props
  List<Object> get props => null;

  /// This method returns the object data in the form of a JSON
  Map<String, Object> toJson() {
    return {
      'userId': this.userId,
      'userName': this.userName,
      'phoneNnum': this.phoneNum,
    };
  }

  /// This method converts the input JSON to the entity object
  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(json['userId'] as String, json['userName'] as String, json['phoneNum'] as String);
  }

  /// This method converts the input Firestore documenta snapshot to the entity object
  static UserEntity fromDocument(DocumentSnapshot snapShot) {
    return UserEntity(snapShot.documentID, snapShot.data['userName'], snapShot.data['phoneNum']);
  }

  /// This method converts the entity object to Firestore document. Since firestore creates a unique document Id for every record,
  /// we dont have to set any explicit unique identifier for the record.
  Map<String, Object> toDocument() {
    return {'userName': this.userName, 'phoneNum': this.phoneNum};
  }
}
