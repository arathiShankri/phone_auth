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
            Text(
              'Success!!',
              textScaleFactor: 2.0,
            ),
          ],
        ));
  }
}
