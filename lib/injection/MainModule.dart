import 'package:flutter_simple_dependency_injection/Injector.dart';
import 'package:myturn/injection/GroupModule.dart';
import 'package:myturn/core/CoreModule.dart';
import 'package:myturn/injection/RepoModule.dart';

/// AbstractModule that all modules extend to
abstract class AbstractModule {
  Injector _injector;
  void configure(Injector injector);

  AbstractModule() {
    _injector ??= Injector.getInjector();
  }
  T get<T>({String key, Map<String, dynamic> additionalParameters}) {
    return this._injector.get(key: key, additionalParameters: additionalParameters);
  }
}

/// This is the MainModule that install all other modules that this project needs
/// All classes are registered with the injector and can be retrieved using MainModule.get<T>()
class MainModule extends AbstractModule {
  static final MainModule _mainModule = new MainModule._internal();

  factory MainModule() {
    return _mainModule;
  }

  MainModule._internal() {
    this.configure(_injector);
  }

  @override
  void configure(Injector injector) {
    CoreModule().configure(injector);
    GroupModule().configure(injector);
    RepoModule().configure(injector);
  }
}
