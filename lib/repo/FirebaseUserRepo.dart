import 'package:myturn/core/repo/AbstractUserRepo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myturn/models/user.dart';

class FirebaseUserRepo implements AbstractUserRepo {
  final FirebaseAuth _firebaseAuth;
  String _smsVerificationCode = "";

  FirebaseUserRepo({FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<String> authenticate(String phoneNumber) async {
    String result;

    await _firebaseAuth
        .verifyPhoneNumber(
            phoneNumber: "+1" + phoneNumber,
            timeout: Duration(seconds: 5),
            verificationCompleted: (authCredential) => _verificationComplete(authCredential),
            // if there is an exception, get the exception message and set it to the return value
            verificationFailed: (authException) => result = _verificationFailed(authException),
            codeAutoRetrievalTimeout: (verificationId) => _codeAutoRetrievalTimeout(verificationId),
            // called when the SMS code is sent
            codeSent: (verificationId, [code]) => _smsCodeSent(verificationId, [code]))
        .then((onValue) async {
      result = 'Success!! ' + (await _firebaseAuth.currentUser()).uid;
    });
    return result;
  }

  @override
  Future<User> getUser() async {
    /// ?? Looks like firebase user table has most of the required information, need to check if we need a application level table
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    return User(userId: firebaseUser.uid, userName: firebaseUser.displayName, phoneNum: firebaseUser.phoneNumber);
  }

  @override
  Future<bool> isAuthenticated() async {
    final currentUser = await _firebaseAuth.currentUser();
    // return true or false depending on whether we have a current user
    return currentUser != null;
  }

  /// will get an AuthCredential object that will help with logging into Firebase.
  _verificationComplete(AuthCredential authCredential) {
    FirebaseAuth.instance.signInWithCredential(authCredential).then((authResult) {});
  }

  _smsCodeSent(String verificationId, List<int> code) {
    // set the verification code so that we can use it to log the user in
    _smsVerificationCode = verificationId;
  }

  String _verificationFailed(AuthException authException) {
    return authException.message;
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    // set the verification code so that we can use it to log the user in
    _smsVerificationCode = verificationId;
  }
}
