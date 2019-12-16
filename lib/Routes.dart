import 'package:flutter/widgets.dart';
import 'package:myturn/bookslot/BookSlot.dart';

import 'ui/HomeScreen.dart';
import 'ui/CreateGroupScreen.dart';

class Routes {
  Routes();
  static const String createGroup = '/createGroup';
  static const String bookSlot = '/bookSlot';

  String initalRoute() {
    return '/';
  }

  Map<String, WidgetBuilder> routes() {
    return {
      '/': (context) => HomeScreen(),
      createGroup: (context) => CreateGroupScreen(),
      bookSlot: (context) => BookSlotScreen(),
      //pauseTimer: (context) => PauseTimerScreen(),
    };
  }
}
