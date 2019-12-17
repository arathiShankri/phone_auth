//import 'package:flutter_simple_dependency_injection/';
import 'package:flutter_simple_dependency_injection/Injector.dart';
import 'package:myturn/injection/MainModule.dart';
import 'package:myturn/Routes.dart';
import 'package:myturn/core/theme/AppTheme.dart';

class CoreModule extends AbstractModule {
  CoreModule();

  @override
  void configure(Injector injector) {
    injector.map<ContemporaryTheme>((i) => ContemporaryTheme(), isSingleton: true);
    injector.map<Routes>((i) => Routes(), isSingleton: true);
  }
}
