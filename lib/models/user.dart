import 'package:equatable/equatable.dart';
import 'package:myturn/entities/entities.dart';

class User extends Equatable {
  final String userId;
  final String userName;
  final String phoneNum;

  User(this.userId, this.userName, this.phoneNum);

  @override
  // instead of doing super for equatable, we are doing this.
  List<Object> get props => [this.userId, this.userName, this.phoneNum];

  /// toEntity - This method converts the User POJO to an entity object
  /// The entity class has further methods to convert the POJO to datastore related objects
  UserEntity toEntity() {
    return UserEntity(userId, userName, phoneNum);
  }

  /// fromEntity - This method creates the POJO back from the entity object
  static User fromEntity(UserEntity entity) {
    return User(entity.userId, entity.userName, entity.phoneNum);
  }
}
