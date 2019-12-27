import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupOptionsScreen {
  Widget groupOptions(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 200),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(child: LayoutBuilder(builder: (context, constraint) {
              // _matchIcons(constraint.biggest.width, constraint.biggest.height)
              return Container(padding: EdgeInsets.fromLTRB(5, 20, 5, 20), child: _matchIcons(400, 400));
            })),
          ],
        ));
  }

  Widget _matchIcons(double constraintWidth, double constraintHeight) {
    List<IconData> icons = [Icons.search, Icons.create];
    return Table(
        defaultColumnWidth: FixedColumnWidth((constraintWidth / icons.length)),
        children: List<TableRow>.generate(
            1,
            (rowIndex) => TableRow(
                    children: List<Widget>.generate(icons.length, (colIndex) {
                  return IconButton(
                    icon: Icon(icons[colIndex]),
                    onPressed: () => debugPrint("create"),
                  );
                }))));
  }
}
