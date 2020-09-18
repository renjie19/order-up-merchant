import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_up_merchant/commons/models/item.dart';
import 'package:order_up_merchant/commons/utils/audit_trail_util.dart';

class ItemUtil {
  static Map<String, Object> toMap(Item item) {
    if(item == null) {
      return null;
    }
    Map<String, Object> map = {
      'name' : item.name,
      'quantity' : item.quantity,
      'package' : item.package,
      'price' : item.price
    };
    AuditTrailUtil.toMap(item, map);
    return map;
  }

  static Item toEntity(Map<String, Object> map) {
    if(map == null || map.isEmpty) {
      return null;
    }
    Item item = Item();
    AuditTrailUtil.toEntity(map, item);
    item.name = map['name'];
    item.quantity = map['quantity'];
    item.package = map['package'];
    item.price = map['price'];
    return item;
  }

  static List<Item> toEntities(List<Map<String, Object>> maps) {
    if(maps.isEmpty) {
      return null;
    }
    return maps.map((e) => toEntity(e)).toList();
  }

  static List<Item> documentsToEntities(List<DocumentSnapshot> snapshots) {
    if(snapshots == null || snapshots.isEmpty) {
      return null;
    }
    return snapshots.map((e) => toEntity(e.data)).toList();
  }

  static Item documentToEntity(DocumentSnapshot snapshot) {
    if(snapshot == null || !snapshot.exists) {
      return null;
    }
    return toEntity(snapshot.data);
  }

  static toMapList(List<Item> items) {
    if(items == null || items.isEmpty) {
      return items.map((e) => toMap(e)).toList();
    }
  }
}