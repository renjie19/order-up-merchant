import 'package:get_it/get_it.dart';
import 'package:order_up_merchant/commons/models/order.dart';
import 'package:order_up_merchant/commons/utils/user_tracker.dart';
import 'package:order_up_merchant/services/firestore/firestore_service.dart';

class OrderService {
  final FirestoreService _firestoreService = GetIt.I<FirestoreService>();
  final UserTracker _tracker = GetIt.I<UserTracker>();

  Future<Order> update(Order order) async {
    return await _firestoreService.updateOrder(order);
  }

  Future<List<Order>> findOrders() async {
    return await _firestoreService.findOrdersByMerchant(_tracker.getUserId());
  }

  Future<Order> findOrder(String id) async {
    return await _firestoreService.findOrder(id);
  }

  Stream<List<Order>> listenToChanges() {
    return _firestoreService.orderUpdates(_tracker.getUserId());
  }
}