import 'package:flutter/widgets.dart';
import 'package:myturn/bookslot/BookSlot.dart';
import 'package:myturn/models/group.dart';
import 'package:myturn/ui/GroupOptionsScreen.dart';

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
      bookSlot: (context) => BookSlotScreen(),
      // groupOptions: (context) => GroupOptionsScreen(),
      //pauseTimer: (context) => PauseTimerScreen(),
    };
  }
}
