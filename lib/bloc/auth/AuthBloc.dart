import 'package:flutter/material.dart';
import 'package:myturn/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:myturn/core/repo/repo.dart';
import 'package:myturn/models/models.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AbstractAuthRepo _authRepo;

  AuthBloc({@required AbstractAuthRepo authRepo})
      : assert(authRepo != null),
        _authRepo = authRepo;

  @override
  AuthState get initialState => UninitializedState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    switch (event.name()) {
      case AuthEvents.AppStart:
        yield* mapAppStartToState();
        break;
      case AuthEvents.SendCode:
        yield* mapSendCodeState(event);
        break;
      case AuthEvents.ResendCode:
        yield* mapResendCodeState(event);
        break;
      case AuthEvents.VerifyPhoneNumber:
        yield* mapVerifyPhoneNumberState(event);
        break;
    }
  }

  /// This method checks if the user is authenticated/logged in and sends back the corresponding state.
  /// This is usually done during App Load time to determine if the user is already authenticated or not.
  Stream<AuthState> mapAppStartToState() async* {
    try {
      final isAuthenticated = await _authRepo.isAuthenticated();
      if (isAuthenticated) {
        yield AuthenticatedState(user: await _authRepo.getUser());
      } else {
        yield UnAuthenticatedState();
      }
    } catch (_) {
      yield UnAuthenticatedState();
    }
  }

  /// This state is in response to the event to send sms code to user's phone number.
  Stream<AuthState> mapSendCodeState(AuthEvent event) async* {
    await _authRepo.verifyPhoneNumber((event as SendCode).phoneNumber);
    yield CodeSentState();
    //await _userRepo.authenticate((event as SendCode).phoneNumber
  }

  /// This state is in response to the event when user wants to the SMS code to be resent.
  /// The code is not regnerated, but the existing code will be sent.
  Stream<AuthState> mapResendCodeState(AuthEvent event) async* {
    await _authRepo.verifyPhoneNumber((event as ResendCode).phoneNumber);
    yield CodeSentState();
  }

  /// This state is in reponse to the event when user enters the SMS code and wants to
  /// sigin with the phone number
  Stream<AuthState> mapVerifyPhoneNumberState(AuthEvent event) async* {
    User _user = _authRepo.signInWithSmsCode((event as VerifyPhoneNumber).smsCode);
    yield AuthenticatedState(user: _user);
    // check for exceptions and yield UnAuthenticatedState if there's an exception.
  }
}
