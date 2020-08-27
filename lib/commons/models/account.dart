import 'package:order_up_merchant/commons/models/audit_trail.dart';
import 'package:order_up_merchant/commons/models/order.dart';
import 'package:order_up_merchant/commons/models/user.dart';

class Account extends AuditTrail {
  User user;
  List<Order> orders;
}