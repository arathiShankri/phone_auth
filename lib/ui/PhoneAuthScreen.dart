import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myturn/bloc/auth/auth_bloc.dart';
import 'package:myturn/core/theme/AppTheme.dart';
import 'package:myturn/injection/AuthModule.dart';
import 'package:myturn/ui/GroupOptionsScreen.dart';

class PhoneAuthScreen extends StatelessWidget {
  final AuthBloc _authBloc = AuthModule().get<AuthBloc>();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder(
            bloc: _authBloc,
            builder: (BuildContext context, AuthState authState) {
              return _body(context, authState);
            }));
  }

  /// Method
  Widget _body(BuildContext context, AuthState authState) {
    Widget widget;

    ///to set common media query attributes in current theme
    ThemeProvider.of(context).currentTheme.mediaQueryData(MediaQuery.of(context));

    switch (authState.name()) {
      case AuthStates.UninitializedState:
        // Check if the user is authenticated or not
        this._authBloc.add(AuthModule().get<AppStart>()); // this event will either send back Authenticated or UnAuthenticated
        widget = Center(
            child: CircularProgressIndicator(
          value: null, // drawing of the circle does not depend on any value
          strokeWidth: 5.0, // line width
        ));
        break;
      case AuthStates.CodeSentState:
        debugPrint("CodeSendState");
        // After sms code is sent to the user, display the widget to enter sms code
        widget = _getSmsCode(context);
        break;
      case AuthStates.UnAuthenticatedState:
        // If user is not authenticated, then display the screen to enter phone number to authenticate the user.
        widget = _getUserPhone(context);
        break;
      case AuthStates.AuthenticatedState:
        debugPrint("AuthenticatedState");
        // Check if the user is in group, if not show screen that will display Group Options
        // IF the user is already in a group, show the screen that displays booked slots and ability to add new slot
        widget = GroupOptionsScreen().groupOptions(context);
        break;
    }
    return widget;
  }

  /// Method that returns a widget with textfield+button to get the phone number from the user
  Widget _getUserPhone(BuildContext context) {
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
          onPressed: () => _sendCode(phoneNumController.text),
        ),
      ],
    );
  } // end of _getUserPhone

  /// method to verify phone number and handle phone auth
  _sendCode(String phoneNumber) async {
    this._authBloc.add(
        // set the phonenumber to the event and dispatch the SendCode event to Bloc to verifythe phonenumber i.e. to send the sms code
        AuthModule().get<SendCode>(additionalParameters: {'phoneNumber': phoneNumber})); // this event will either send back Authenticated or UnAuthenticated
  } // end of _sendCode

  /// Method that returns a widget with textfield+button to get the SMS code that was sent to the user
  Widget _getSmsCode(BuildContext context) {
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
          onPressed: () => _signInWithCode(codeController.text),
        ),
        FlatButton(
          color: ThemeProvider.of(context).currentTheme.getTheme().buttonColor,
          child: Text("Resend Code"),
          onPressed: () => _getUserPhone(context),
        ),
      ],
    );
  } // end of _getSmsCode

  // smsCode is the code that is sent to the users phone that they enter in the textfield
  _signInWithCode(String smsCode) {
    // now that the user has entered the sms code, its time to signIn the user with their phone number
    this
        ._authBloc
        .add(AuthModule().get<VerifyPhoneNumber>(additionalParameters: {'smsCode': smsCode})); // this event will either send back Authenticated or UnAuthenticated
  } // end of _sendCode

}
