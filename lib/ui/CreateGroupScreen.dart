import 'package:flutter/material.dart';
import 'package:myturn/MainModule.dart';
import 'package:myturn/core/theme/AppTheme.dart';

class CreateGroupScreen extends StatefulWidget {
  CreateGroupScreen() : super();

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final MainModule mainModule = MainModule();

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      currentTheme: this.mainModule.get<ContemporaryTheme>(),
      child: Builder(
        builder: (context) => Container(
            color: Theme.of(context).backgroundColor,
            child: SafeArea(
              minimum: const EdgeInsets.fromLTRB(8, 35, 8, 10), //provide extra padding on all 4 sides
              child: _screen(context),
            )),
      ),
    );
  } //build

  Widget _screen(BuildContext context) {
    ///to set common media query attributes in current theme
    ThemeProvider.of(context).currentTheme.mediaQueryData(MediaQuery.of(context));

    return Scaffold(
      appBar: AppBar(
          //title: Text("Group"),
          ),
      body: _body(context),
      bottomNavigationBar: _bottomNav(context),
    );
  } //_screen

  /// build body
  Widget _body(BuildContext context) {
    return _formFields();
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
              icon: Icon(Icons.save),
              tooltip: "Search",
              onPressed: () => debugPrint("on save"),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => debugPrint("on schedule"),
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () => debugPrint("on schedule"),
            )
          ],
        ),
      ),
    );
  }

  Widget _formFields() {
    return Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Group Name"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Address"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Phone #"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "How many chargers are you managing?"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Slot Duration in hrs"),
            ),
          ],
        ));
  }
} // End of CreateGroupScreen
