import 'package:order_up_merchant/commons/models/audit_trail.dart';
import 'package:order_up_merchant/commons/models/payment_info.dart';
import 'package:order_up_merchant/commons/utils/audit_trail_util.dart';

class PaymentInfoUtil {
  static PaymentInfo toEntity(Map<String, Object> map) {
    if(map == null) {
      return null;
    }
    PaymentInfo paymentInfo = PaymentInfo();
    AuditTrailUtil.toEntity(map, paymentInfo);
    paymentInfo.amountPaid = map['amountPaid'];
    paymentInfo.balance = map['balance'];
    return paymentInfo;
  }

  static Map<String, Object> toMap(PaymentInfo paymentInfo) {
    if(paymentInfo == null) {
      return null;
    }
    Map<String, Object> map = {};
    AuditTrailUtil.toMap(paymentInfo, map);
    map['amountPaid'] = paymentInfo.amountPaid;
    map['balance'] = paymentInfo.balance;
    return map;
  }

  static List<PaymentInfo> toEntities(List<Map<String, Object>> maps) {
    if(maps == null) {
      return null;
    }
    return maps.map((e) => toEntity(e)).toList();
  }

  static List<Map<String, Object>> toMaps(List<PaymentInfo> paymentInfos) {
    if(paymentInfos == null) {
      return null;
    }
    return paymentInfos.map((e) => toMap(e)).toList();
  }
}