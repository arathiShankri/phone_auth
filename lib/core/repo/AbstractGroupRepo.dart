import 'package:myturn/models/group.dart';

abstract class AbstractGroupRepo {
  Future<void> addGroup(Group group);

  Future<void> deleteGroup(Group group);

  Future<void> updateGroup(Group group);
}
