import 'package:flutter/material.dart';
import 'package:myturn/core/theme/AppTheme.dart';

class PhoneAuthScreen {
  /// Widget to build the textfields
  Widget buildPhoneAuthTextFields(BuildContext context) {
    ///to set common media query attributes in current theme
    ThemeProvider.of(context).currentTheme.mediaQueryData(MediaQuery.of(context));

    TextEditingController phoneNumController = TextEditingController();
    TextEditingController codeController = TextEditingController();
    return Container(
        //alignment: Alignment.center,
        width: 360,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,

              children: <Widget>[
                TextField(
                  expands: false,
                  controller: phoneNumController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: "Enter your phone number",
                      alignLabelWithHint: true,
                      labelStyle: ThemeProvider.of(context).currentTheme.getTheme().textTheme.caption,
                      prefixText: "+1",
                      //border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder()),
                ),
                FlatButton(
                    color: ThemeProvider.of(context).currentTheme.getTheme().buttonColor,
                    child: Text("Send code"),
                    onPressed: () => debugPrint("code sent") //_verifyPhoneNumber(context),
                    ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: codeController,
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "Enter sms code",
                      labelStyle: ThemeProvider.of(context).currentTheme.getTheme().textTheme.caption,
                      focusedBorder: OutlineInputBorder()),
                ),
                FlatButton(
                    color: ThemeProvider.of(context).currentTheme.getTheme().buttonColor,
                    child: Text("Confirm Code"),
                    onPressed: () => debugPrint("sign in with code") //_signInWithCode(codeController.text),
                    ),
              ],
            ),
          ],
        ));
  }
}
