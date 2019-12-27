import 'package:myturn/models/user.dart';

abstract class AbstractAuthRepo {
  Future<bool> isAuthenticated();

  Future<void> verifyPhoneNumber(String phoneNum);

  Future<User> getUser();

  User signInWithSmsCode(String smsCode);
}
