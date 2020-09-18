import 'package:order_up_merchant/commons/models/user.dart';

class UserTracker {
  String _userId;
  User _user;

  User getUser() => _user;

  void setUser(User value) => _user = value;

  void setUserId(String userId) => _userId = userId;

  String getUserId() {
    return _userId;
  }
}