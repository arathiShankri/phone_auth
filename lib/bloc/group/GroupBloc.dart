import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:myturn/core/bloc/AbstractEvent.dart';
import 'package:myturn/core/repo/repo.dart';
import 'GroupEvents.dart';
import 'GroupStates.dart';

/// Bloc that handles Group related functionality
class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final AbstractGroupRepo groupRepo;
  @override
  GroupState get initialState => null;

  GroupBloc({@required this.groupRepo});

  @override
  // Will consume an event/trigger and emit/yield a state
  Stream<GroupState> mapEventToState(AbstractEvent event) async* {
    switch (event.name()) {
      case GroupEvents.LoadGroup:
        break;
      case GroupEvents.AddGroup:
        yield* _mapAddGroupToState(event);
        break;
      case GroupEvents.EditGroup:
        yield* _mapEditGroupToState(event.name());
        break;
      case GroupEvents.DeleteGroup:
        yield* _mapDeleteGroupToState(event.name());
        break;
    } // end of switch
  } // end of mapEventToState

  Stream<GroupState> _mapAddGroupToState(AbstractEvent event) async* {
    this.groupRepo.addGroup((event as AddGroup).group);
  }

  Stream<GroupState> _mapEditGroupToState(AddGroup event) async* {
    this.groupRepo.updateGroup(event.group);
  }

  Stream<GroupState> _mapDeleteGroupToState(AddGroup event) async* {
    this.groupRepo.deleteGroup(event.group);
  }
}
