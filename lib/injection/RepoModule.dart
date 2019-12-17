import 'package:flutter_simple_dependency_injection/Injector.dart';
import 'package:myturn/injection/MainModule.dart';
import 'package:myturn/repo/FirebaseGroupRepo.dart';
import 'package:myturn/repo/FirebaseUserRepo.dart';

//all modules are singletons
class RepoModule extends AbstractModule {
  static final RepoModule _groupModule = RepoModule._internal();

  factory RepoModule() {
    return _groupModule;
  }

  RepoModule._internal();

  @override
  void configure(Injector injector) {
    injector.map<FirebaseGroupRepo>((i) => FirebaseGroupRepo(), isSingleton: false);
    injector.map<FirebaseUserRepo>((i) => FirebaseUserRepo(), isSingleton: false);
  }
}
