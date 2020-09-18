import 'package:order_up_merchant/commons/models/audit_trail.dart';
import 'package:order_up_merchant/commons/models/item.dart';
import 'package:order_up_merchant/commons/models/payment_info.dart';
import 'package:order_up_merchant/commons/models/user.dart';

class Order extends AuditTrail {
  String merchantId;
  User user;
  List<Item> items;
  String status;
  List<PaymentInfo> payments;

  double get total {
    return items.fold(
        0.0, (previousValue, element) => previousValue + element.price);
  }
}
