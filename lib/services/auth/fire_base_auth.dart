
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:order_up_merchant/commons/utils/user_tracker.dart';

import 'auth_service.dart';

class FireBaseAuth implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  signIn(String email, String password) async {
   return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  signOut() {
    _firebaseAuth.signOut();
  }

  @override
  signUp(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  listenToUserChange() {
    return _firebaseAuth.onAuthStateChanged;
  }

}