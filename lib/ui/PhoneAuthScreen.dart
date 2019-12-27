import 'package:flutter/material.dart';
import 'package:myturn/core/theme/AppTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Routes.dart';

class PhoneAuthScreen extends StatefulWidget {
  PhoneAuthScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String _smsVerificationCode = "";
  String userId = "";

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("userId = " + userId);
    return _buildPhoneAuthTextFields(context);
  }

  /// Widget to build the textfields
  Widget _buildPhoneAuthTextFields(BuildContext context) {
    ///to set common media query attributes in current theme
    ThemeProvider.of(context).currentTheme.mediaQueryData(MediaQuery.of(context));

    return Container(
        //alignment: Alignment.center,
        width: 360,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_buildChild()],
        ));
  }

// This method displays the enter phone num widget or enter sms code widget depending on whether the user had entered the phone number.
  Widget _buildChild() {
    // If sms verification is not sent
    if (_smsVerificationCode.length == 0) {
      // display the widget that will ask user to enter their phone number
      return _getUserPhone();
    } else {
      // else display the widget that will ask user to enter the code that was sent
      return _getSmsCode();
    }
  }

  /// Method that returns a widget with textfield+button to get the phone number from the user
  Widget _getUserPhone() {
    return Column(
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
          onPressed: () => _verifyPhoneNumber(context),
        ),
      ],
    );
  }

  /// Method that returns a widget with textfield+button to get the SMS code that was sent to the user
  Widget _getSmsCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "SMS code was sent to " + phoneNumController.text.toString() + "\n",
          textScaleFactor: 1.5,
          style: TextStyle(color: ThemeProvider.of(context).currentTheme.getTheme().errorColor),
        ),
        TextField(
          controller: codeController,
          decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: "Enter Code",
              labelStyle: ThemeProvider.of(context).currentTheme.getTheme().textTheme.caption,
              focusedBorder: OutlineInputBorder()),
        ),
        FlatButton(
          color: ThemeProvider.of(context).currentTheme.getTheme().buttonColor,
          child: Text("Verify Phone Number"),
          onPressed: () => _signInWithCode(codeController.text, context),
        ),
      ],
    );
  }

  /// method to verify phone number and handle phone auth
  _verifyPhoneNumber(BuildContext context) async {
    String phoneNumber = "+1" + phoneNumController.text.toString();

    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(microseconds: 0),
        verificationCompleted: (authCredential) => _verificationComplete(authCredential, context),
        verificationFailed: (authException) => _verificationFailed(authException, context),
        codeAutoRetrievalTimeout: (verificationId) => _codeAutoRetrievalTimeout(verificationId),
        // called when the SMS code is sent
        codeSent: (verificationId, [code]) => _smsCodeSent(verificationId, [code]));
  }

  /// will get an AuthCredential object that will help with logging into Firebase. This method is called when
  /// the instant verification happens using PlayServices, but when we set the duration = 0, this method is not invoked.
  /// but _codeAutoRetrievalTimeout method is called.
  _verificationComplete(AuthCredential authCredential, BuildContext context) {}

  _smsCodeSent(String verificationId, List<int> code) {
    // set the verification code so that we can use it to log the user in
    setState(() {
      _smsVerificationCode = verificationId;
    });
  }

  _verificationFailed(AuthException authException, BuildContext context) {
    debugPrint("verification failed");
    debugPrint("Exception!! message:" + authException.message.toString());
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    // set the verification code so that we can use it to log the user in
    setState(() {
      _smsVerificationCode = verificationId;
    });
    debugPrint("_codeAutoRetrievalTimeout" + _smsVerificationCode);
  }

  // smsCode is the code that is sent to the users phone that they enter in the textfield
  _signInWithCode(String smsCode, BuildContext context) {
    debugPrint("verif in sign in" + _smsVerificationCode);
    debugPrint("smsCode" + smsCode.toString());

    AuthCredential authCredential = PhoneAuthProvider.getCredential(smsCode: smsCode, verificationId: _smsVerificationCode);
    FirebaseAuth.instance.signInWithCredential(authCredential).then((authResult) {
      final snackBar = SnackBar(content: Text("Success!!! UUID is: " + authResult.uid));
      userId = authResult.uid;
      Scaffold.of(context).showSnackBar(snackBar);
      Navigator.pushNamed(context, Routes.groupOptions);
    });
  }
}
