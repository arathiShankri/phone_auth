import 'package:myturn/core/bloc/AbstractEvent.dart';

enum AuthEvents { AppStart, LogIn }

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

/// This is the event triggered when trying to login the user
class LogIn extends AuthEvent {
  @override
  AuthEvents name() {
    return AuthEvents.LogIn;
  }
}
