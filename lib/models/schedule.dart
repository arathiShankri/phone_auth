import 'package:equatable/equatable.dart';
import 'package:myturn/entities/entities.dart';

class Schedule extends Equatable {
  final String userId;
  final String userName;
  final String createdAt;
  final String slotTime;

  Schedule(this.userId, this.userName, this.slotTime, this.createdAt);

  @override
  List<Object> get props => [this.userId, this.userName, this.slotTime, this.createdAt];

  /// toEntity - This method converts the User POJO to an entity object
  /// The entity class has further methods to convert the POJO to datastore related objects
  ScheduleEntity toEntity() {
    return ScheduleEntity(this.userId, this.userName, this.slotTime, this.createdAt);
  }

  /// fromEntity - This method creates the POJO back from the entity object
  static Schedule fromEntity(ScheduleEntity entity) {
    return Schedule(entity.userId, entity.userName, entity.slotTime, entity.createdAt);
  }
}
