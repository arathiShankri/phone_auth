import 'package:flutter/widgets.dart';

import 'ui/HomeScreen.dart';
import 'ui/CreateGroupScreen.dart';

class Routes {
  Routes();
  static const String createGroup = '/createGroup';
  static const String bookSlot = '/bookSlot';
  static const String groupOptions = '/GroupOptionsScreen';

  String initalRoute() {
    return '/';
  }

  Map<String, WidgetBuilder> routes() {
    return {
      '/': (context) => HomeScreen(),
      createGroup: (context) => CreateGroupScreen(),
      // groupOptions: (context) => GroupOptionsScreen(),
      //pauseTimer: (context) => PauseTimerScreen(),
    };
  }
}
