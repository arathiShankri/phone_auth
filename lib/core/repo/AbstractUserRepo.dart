import 'package:myturn/models/user.dart';

abstract class AbstractUserRepo {
  Future<bool> isAuthenticated();

  Future<String> authenticate(String phoneNum);

  Future<User> getUser();
}
