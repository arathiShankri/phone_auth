import 'package:flutter/material.dart';
import 'package:myturn/core/bloc/AbstractEvent.dart';
import 'package:myturn/models/models.dart';

enum GroupEvents { LoadGroup, AddGroup, EditGroup, DeleteGroup, InviteToGroup, ChkUserInGroup }

abstract class GroupEvent extends AbstractEvent {}

/// Event that is triggerred to load a group that the user is an Admin of
class LoadGroup extends GroupEvent {
  final String userId;

// {} -  is used to specify named parameters
// annotating with @ required because we need userId to load the group
  LoadGroup({@required this.userId});

  @override
  GroupEvents name() {
    return GroupEvents.LoadGroup;
  }
}

/// Event that is invoked to Add a new Group
class AddGroup extends GroupEvent {
  final Group group;

// Add the corresponding group object.
  AddGroup({@required this.group});

  @override
  GroupEvents name() {
    return GroupEvents.AddGroup;
  }
}

/// Event that is invoked to modify an existing Group
class EditGroup extends GroupEvent {
  final Group group;

  // Edit the corresponding group object
  EditGroup({@required this.group});
  @override
  GroupEvents name() {
    return GroupEvents.EditGroup;
  }
}

/// Event that is invoked to delete an existing Group
class DeleteGroup extends GroupEvent {
  final Group group;

  DeleteGroup({@required this.group});

  @override
  GroupEvents name() {
    return GroupEvents.DeleteGroup;
  }
}

/// Event to invite other users to the group
class InviteToGroup extends GroupEvent {
  @override
  GroupEvents name() {
    return GroupEvents.InviteToGroup;
  }
}

/// Event to check if a certain user is in any group or in a certain group that is sent as input value to the constructor
/// Hence, the group is not a required field
class ChkUserInGroup extends GroupEvent {
  final Group group;
  final User user;

  ChkUserInGroup({@required this.user, this.group});

  @override
  GroupEvents name() {
    return GroupEvents.ChkUserInGroup;
  }
}
