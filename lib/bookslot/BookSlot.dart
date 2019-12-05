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
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint("FAB pressed"),
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Book your turn",
          textScaleFactor: 1.2,
        ),
        centerTitle: true,
      ),
      body: _body(context),
    );
  } //_screen

  /// build body
  Widget _body(BuildContext context) {
    return _buildScheduleList(context);
  }

  Widget _buildScheduleList(BuildContext context) {
    final List<String> entries = <String>['Shellu', 'Raju', 'Vinay'];
    final List<String> colorCodes = <String>['9:00 - 10:00', '10:00 - 11:00', '11:00 - 12.00'];

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length + 1, // should always have a count
      itemBuilder: (BuildContext context, int index) {
        ListTile listTile;
        if (index < entries.length) {
          listTile = ListTile(
            title: Text('${entries[index]}'),
            subtitle: Text('${colorCodes[index]}'),
          );
        } else {
          listTile = ListTile(
            title: Text('  '),
            subtitle: Text('   '),
            leading: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _bookMyTurn(context),
            ),
          );
        }
        return listTile;
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  _bookMyTurn(BuildContext context) {
    // should add a record for the user in the schedule table.
    // the list should refresh automatically
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
