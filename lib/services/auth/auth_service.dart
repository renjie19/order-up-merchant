abstract class AuthService {
  signIn(String email, String password);
  signUp(String email, String password);
  signOut();
  Stream listenToUserChange();
}