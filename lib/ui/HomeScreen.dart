import 'package:flutter/material.dart';
import 'package:myturn/injection/MainModule.dart';
import 'package:myturn/Routes.dart';
import 'package:myturn/core/theme/AppTheme.dart';
import 'package:myturn/ui/PhoneAuthScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() : super();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MainModule mainModule = MainModule();

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      currentTheme: this.mainModule.get<ContemporaryTheme>(),
      child: Builder(
        builder: (context) => Container(
            color: Theme.of(context).backgroundColor,
            child: SafeArea(
              minimum: const EdgeInsets.fromLTRB(5, 55, 5, 10), //provide extra padding on all 4 sides
              child: _screen(context),
            )),
      ),
    );
  } //build

  Widget _screen(BuildContext context) {
    ///to set common media query attributes in current theme
    ThemeProvider.of(context).currentTheme.mediaQueryData(MediaQuery.of(context));

    return Scaffold(
      drawerScrimColor: Theme.of(context).backgroundColor,
      appBar: _appBar(context),
      body: _body(context),
      // show this only when the user is authenticated
      bottomNavigationBar: _bottomNav(context),
    );
  } //_screen

  /// build body
  _body(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[_header(), PhoneAuthScreen().buildPhoneAuthTextFields(context)]);
  }

  Widget _header() {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
        alignment: Alignment.center,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: <Widget>[
          Text(
            "Hello! Welcome to MyTurn!",
            textScaleFactor: 2.0,
          ),
          Text(""),
          Text(
            "Lets get you started!",
            textScaleFactor: 1.5,
          ),
        ]));
  }

  ///Using PreferredSize instead of directly using an AppBar to provide box decoration and other styling
  ///PreferredSize needs 'preferredSize' attribute
  PreferredSize _appBar(BuildContext context) {
    return PreferredSize(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: BoxDecoration(
          border: Border.all(color: ThemeProvider.of(context).currentTheme.appBarBorder()),
          borderRadius: BorderRadius.circular(6),
        ),
        child: AppBar(
          automaticallyImplyLeading: false,
          //leading: _drawerIcon(state),
          centerTitle: false,
          title: Text('MyTurn'),
          // actions: _appBarActions(context, state),
        ),
      ),
      preferredSize: Size.fromHeight(50),
    );
  }

  /// ***** start: bottom navbar *****
  BottomAppBar _bottomNav(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        decoration: BoxDecoration(border: Border(top: BorderSide(color: ThemeProvider.of(context).currentTheme.bottomBarBorder()))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: "Search",
              onPressed: () => debugPrint("on create"),
            ),
            IconButton(
              icon: Icon(Icons.schedule),
              onPressed: () => Navigator.pushNamed(context, Routes.bookSlot),
            ),
            IconButton(
              icon: Icon(Icons.create),
              onPressed: () => Navigator.pushNamed(context, Routes.createGroup),
            )
          ],
        ),
      ),
    );
  }
}
