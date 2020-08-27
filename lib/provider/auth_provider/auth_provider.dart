import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:order_up_merchant/commons/utils/user_tracker.dart';
import 'package:order_up_merchant/services/auth/auth_service.dart';
import 'package:order_up_merchant/services/auth/fire_base_auth.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = GetIt.I<FireBaseAuth>();
  final UserTracker _tracker = GetIt.I<UserTracker>();
  String _userId;

  String get userId {
    return _userId;
  }

  AuthProvider() {
    _initListener();
  }

  void _initListener() {
    _authService.listenToUserChange().listen((event) {
      if(event == null) {
        _userId = null;
      } else if(event is FirebaseUser) {
        _userId = event.uid;
      }
      _tracker.setUserId(_userId);
      notifyListeners();
    });
  }
}