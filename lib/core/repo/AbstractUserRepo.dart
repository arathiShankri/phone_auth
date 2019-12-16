abstract class AbstractUserRepo {
  Future<bool> isAuthenticated();

  Future<String> authenticate(String phoneNum);

  Future<String> getUserId();
}
