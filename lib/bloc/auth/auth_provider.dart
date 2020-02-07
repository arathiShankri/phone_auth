import 'package:flutter/material.dart';
import 'package:myturn/bloc/auth/AuthStates.dart';
import 'package:myturn/core/repo/repo.dart';
import 'package:myturn/injection/RepoModule.dart';
import 'package:myturn/models/models.dart';
import 'package:myturn/repo/FirebaseAuthRepo.dart';

class AuthProvider with ChangeNotifier {
  // Auth repo is a singleton as well
  final AbstractAuthRepo _authRepo = RepoModule().get<FirebaseAuthRepo>();

  AuthStates _state = AuthStates.UninitializedState;
  AuthStates get state => _state;

  /// This method checks if the user is authenticated/logged in and sends back the corresponding value.
  /// This is usually done during App Load time to determine if the user is already authenticated or not.
  // In Bloc, I sent back the boolean wrapped in a state
  Future<bool> isUserAuthenticated() async {
    return await _authRepo.isAuthenticated();
  }

  /// This state is in response to the event to send sms code to user's phone number.
  // In Bloc, I got the phone number from the event, but now, I am getting a string
  Future<void> sendCode(String phoneNumber) async {
    await _authRepo.verifyPhoneNumber(phoneNumber);
    _state = AuthStates.CodeSentState;
    notifyListeners();
  }

  /// This state is in response to the event when user wants to the SMS code to be resent.
  /// The code is not regnerated, but the existing code will be sent.
  Future<void> resendCodeState(String phoneNumber) async {
    await _authRepo.verifyPhoneNumber(phoneNumber);
    _state = AuthStates.CodeSentState;
    notifyListeners();
  }

  /// This state is in reponse to the event when user enters the SMS code and wants to
  /// sigin with the phone number
  Future<User> verifyPhoneNumberState(String smsCode) async {
    User user = _authRepo.signInWithSmsCode(smsCode);
    if (user == null) {
      // error logging in
      _state = AuthStates.ErrorState;
      notifyListeners();
    } else {
      _state = AuthStates.AuthenticatedState;
      notifyListeners();
    }
    // check for exceptions and yield UnAuthenticatedState if there's an exception.
  }
}
