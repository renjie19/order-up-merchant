import 'package:get_it/get_it.dart';
import 'package:order_up_merchant/commons/models/account.dart';
import 'package:order_up_merchant/commons/utils/user_tracker.dart';
import 'package:order_up_merchant/services/firestore/firestore_service.dart';

class AccountService {
  final FirestoreService _firestoreService = GetIt.I<FirestoreService>();
  final UserTracker _userTracker = GetIt.I<UserTracker>();

  Account create(Account account) {
    return _firestoreService.create(account);
  }

  Account update(Account account) {
    return _firestoreService.update(account);
  }

  Future<Account> get() async {
    var account = await _firestoreService.getAccount(_userTracker.getUserId());
    _userTracker.setUser(account.user);
    return account;
  }

  void deleteAccount() {
    throw UnimplementedError();
  }
}