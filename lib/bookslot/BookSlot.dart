import 'package:flutter/material.dart';
import 'package:myturn/MainModule.dart';
import 'package:myturn/core/theme/AppTheme.dart';

class BookSlotScreen extends StatefulWidget {
  BookSlotScreen() : super();

  @override
  _BookSlotScreenState createState() => _BookSlotScreenState();
}

class _BookSlotScreenState extends State<BookSlotScreen> {
  final MainModule mainModule = MainModule();
  String _selectedTimeSlot = "";
  final int duration = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          debugPrint("on pop");
          Navigator.pop(context);
        },
        child: ThemeProvider(
          currentTheme: this.mainModule.get<ContemporaryTheme>(),
          child: Builder(
            builder: (context) => Container(
                color: Theme.of(context).backgroundColor,
                child: SafeArea(
                  minimum: const EdgeInsets.fromLTRB(8, 35, 8, 10), //provide extra padding on all 4 sides
                  child: _screen(context),
                )),
          ),
        ));
  } //build

  Widget _screen(BuildContext context) {
    ///to set common media query attributes in current theme
    ThemeProvider.of(context).currentTheme.mediaQueryData(MediaQuery.of(context));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book your turn",
          textScaleFactor: 1.2,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            tooltip: "Search",
            onPressed: () => debugPrint("on save"),
          ),
        ],
      ),
      body: _body(context),
      //bottomNavigationBar: _bottomNav(context),
    );
  } //_screen

  /// build body
  Widget _body(BuildContext context) {
    return _buildTimeSlotWidget(duration);
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
          ],
        ),
      ),
    );
  }

  /// method that builds the widget with time slots starting from the current time lasting till the end of the day
  Widget _buildTimeSlotWidget(int duration) {
    List timeSlots = List();
    double endTime = 24.0;

    // Get current time
    DateTime currDateTime = DateTime.now();
    double curHr = currDateTime.hour.toDouble();

    debugPrint("curr Date time=" + curHr.toString());

    // convert endTime into 24hr format
    //endTime = (endTime + 12.0);

    // don't worry about 12 or 24 hr format here
    for (double i = curHr; i <= endTime;) {
      i >= 13.0 ? timeSlots.add(i - 12) : timeSlots.add(i);
      i = i + duration;
    }

    // build listview with radio titles
    return ListView.builder(
        // scrollDirection: Axis.vertical,
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          return RadioListTile(
            title: Text(timeSlots[index].toStringAsFixed(2)),
            value: timeSlots[index].toStringAsFixed(2),
            groupValue: _selectedTimeSlot,
            onChanged: (selectedValue) {
              setState(() => _selectedTimeSlot = selectedValue);
            },
          );
        });
  }
} // End of CreateGroupScreen
