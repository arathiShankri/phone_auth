import 'package:flutter_simple_dependency_injection/Injector.dart';
import 'package:myturn/injection/MainModule.dart';
import 'package:myturn/repo/FirebaseGroupRepo.dart';
import 'package:myturn/bloc/group/group_bloc.dart';

//all modules are singletons
class GroupModule extends AbstractModule {
  static final GroupModule _groupModule = GroupModule._internal();

  factory GroupModule() {
    return _groupModule;
  }

  GroupModule._internal();

  @override
  void configure(Injector injector) {
    //states
    injector.map<GroupLoading>((i) => GroupLoading(), isSingleton: false);
    injector.map<GroupLoaded>((i) => GroupLoaded(), isSingleton: false);
    injector.map<GroupLoadingError>((i) => GroupLoadingError(), isSingleton: false);

    //events
    injector.mapWithParams<LoadGroup>((i, p) => LoadGroup(userId: p['userId']));
    injector.mapWithParams<AddGroup>((i, p) => AddGroup(group: p['group']));
    injector.mapWithParams<EditGroup>((i, p) => EditGroup(group: p['group']));
    injector.mapWithParams<DeleteGroup>((i, p) => DeleteGroup(group: p['group']));

    //injector.mapWithParams<StartGameAtLevelEvent>((i, p) => StartGameAtLevelEvent(level: p['level']));

    //bloc
    injector.map<GroupBloc>((i) => GroupBloc(groupRepo: i.get<FirebaseGroupRepo>()), isSingleton: true);
  }
}
