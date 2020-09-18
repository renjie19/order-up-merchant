import 'package:order_up_merchant/commons/models/account.dart';
import 'package:order_up_merchant/commons/utils/audit_trail_util.dart';
import 'package:order_up_merchant/commons/utils/user_util.dart';

class AccountUtil {
  Account toEntity(Map<String, Object> map) {
    Account account = Account();
    AuditTrailUtil.toEntity(map, account);
    account.user = UserUtil.toEntity(map);
  }

  Map<String, Object> toMap(Account account) {

  }
}