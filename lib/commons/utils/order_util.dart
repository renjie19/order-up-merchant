import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_up_merchant/commons/models/order.dart';
import 'package:order_up_merchant/commons/utils/audit_trail_util.dart';
import 'package:order_up_merchant/commons/utils/item_util.dart';
import 'package:order_up_merchant/commons/utils/user_util.dart';

class OrderUtil {
  static Map<String, Object> toMap(Order order) {
    if(order == null) {
      return null;
    }
    Map<String, Object> map = {};
    AuditTrailUtil.toMap(order, map);
    map['merchantId'] = order.merchantId;
    map['user'] = UserUtil.toMap(order.user);
    map['items'] = ItemUtil.toMapList(order.items);
    map['status'] = order.status;
    // TODO map payments once implemented
    return map;
  }

  static Order toEntity(Map<String, Object> map) {
    if(map == null || map.isEmpty) {
      return null;
    }
    Order order = Order();
    AuditTrailUtil.toEntity(map, order);
    order.merchantId = map['merchantId'];
    order.user = UserUtil.toEntity( map['user']);
    order.items = ItemUtil.toEntities(map['items']);
    order.status = map['status'];
    // TODO  map payment info
    return order;
  }

  static Order documentToEntity(DocumentSnapshot snapshot) {
    if(!snapshot.exists) {
      return null;
    }
    return toEntity(snapshot.data);
  }

  static List<Order> documentsToEntities(List<DocumentSnapshot> snapshots) {
    if(snapshots.isEmpty) {
      return null;
    }
    return snapshots.map((e) => documentToEntity(e)).toList();
  }
}