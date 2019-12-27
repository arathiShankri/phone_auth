import 'package:flutter_simple_dependency_injection/Injector.dart';
import 'package:myturn/injection/MainModule.dart';
import 'package:myturn/repo/FirebaseAuthRepo.dart';
import 'package:myturn/repo/FirebaseGroupRepo.dart';

//all modules are singletons
class RepoModule extends AbstractModule {
  static final RepoModule _groupModule = RepoModule._internal();

  factory RepoModule() {
    return _groupModule;
  }

  RepoModule._internal();

  @override
  void configure(Injector injector) {
    injector.map<FirebaseGroupRepo>((i) => FirebaseGroupRepo(), isSingleton: true);
    injector.map<FirebaseAuthRepo>((i) => FirebaseAuthRepo(), isSingleton: true);
  }
}
