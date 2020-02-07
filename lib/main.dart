import 'package:flutter/material.dart';
import 'package:myturn/bloc/auth/auth_provider.dart';
import 'package:myturn/injection/MainModule.dart';
import 'package:myturn/Routes.dart';
import 'package:provider/provider.dart';

import 'core/theme/AppTheme.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MainModule mainModule = MainModule();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: "MyTurn",
        debugShowCheckedModeBanner: false,
        theme: ContemporaryTheme().getTheme(),
        initialRoute: mainModule.get<Routes>().initalRoute(),
        // Load the routes, so that they are available downstream
        routes: mainModule.get<Routes>().routes(),
      ),
    );
  }
}
// end of class
