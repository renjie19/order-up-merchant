import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:order_up_merchant/commons/utils/user_tracker.dart';

import 'auth_service.dart';

class FireBaseAuth implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  signOut() {
    _firebaseAuth.signOut();
  }

  @override
  Future<AuthResult> signUp(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Stream<FirebaseUser> listenToUserChange() {
    return _firebaseAuth.onAuthStateChanged;
  }

  @override
  Future signIn(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
