import 'package:flutter/material.dart';
import 'package:myturn/core/bloc/AbstractState.dart';
import 'package:myturn/models/models.dart';

// State is really the "state" of your app screen. The Group screen can be loading, loaded and error.
// Event will then be the actions that can take place on your Group screen.

enum GroupStates { GroupLoading, GroupLoaded, GroupLoadingError, UserInGroup, UserNotInGroup }

abstract class GroupState extends AbstractState {}

/// State when Group is loading
class GroupLoading extends GroupState {
  @override
  GroupStates name() {
    return GroupStates.GroupLoading;
  }
}

/// State when Group is loaded
class GroupLoaded extends GroupState {
  //final Group group;

  GroupLoaded();

  @override
  List<Object> get props => [];

  @override
  GroupStates name() {
    return GroupStates.GroupLoaded;
  }
}

/// State when there's an error loading the group
class GroupLoadingError extends GroupState {
  @override
  GroupStates name() {
    return GroupStates.GroupLoadingError;
  }
}

/// State to show that user in group(s)
class UserInGroup extends GroupState {
  final List<Group> groupList;

  UserInGroup({@required this.groupList});

  @override
  GroupStates name() {
    return GroupStates.UserInGroup;
  }
}

/// State to show that user is not in any group(s)
class UserNotInGroup extends GroupState {
  UserNotInGroup();

  @override
  GroupStates name() {
    return GroupStates.UserNotInGroup;
  }
}
