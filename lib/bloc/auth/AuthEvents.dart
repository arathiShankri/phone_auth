import 'package:flutter/material.dart';
import 'package:myturn/core/bloc/AbstractEvent.dart';

enum AuthEvents { AppStart, SendCode, ResendCode, VerifyPhoneNumber }

class AuthEvent extends AbstractEvent {
  @override
  name() {
    return null;
  }
}

/// This is the event triggered when App is starting - user not logged in
class AppStart extends AuthEvent {
  @override
  AuthEvents name() {
    return AuthEvents.AppStart;
  }
}

/// This is the event triggered when user enters phone number to send a code
class SendCode extends AuthEvent {
  final String phoneNumber;

  SendCode({@required this.phoneNumber});

  @override
  AuthEvents name() {
    return AuthEvents.SendCode;
  }
}

/// Event to resend the sms code to user
class ResendCode extends AuthEvent {
  final String phoneNumber;

  ResendCode({@required this.phoneNumber});

  @override
  @override
  AuthEvents name() {
    return AuthEvents.ResendCode;
  }
}

/// Event that is triggered when user enters the sms code and initiates phone number verification
class VerifyPhoneNumber extends AuthEvent {
  final String smsCode;

  VerifyPhoneNumber({@required this.smsCode});
  @override
  AuthEvents name() {
    return AuthEvents.VerifyPhoneNumber;
  }
}
