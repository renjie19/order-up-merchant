import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:order_up_merchant/commons/models/order.dart';
import 'package:order_up_merchant/services/order/order_service.dart';

class OrderListProvider extends ChangeNotifier {
  final OrderService _orderService = GetIt.I<OrderService>();
  List<Order> _orders = [];

  List<Order> get orders {
    return _orders;
  }

  OrderListProvider() {
    _initStream();
  }

  void _initStream() {
    _orderService.listenToChanges().listen((event) {
      _orders = event;
      notifyListeners();
    });
  }
}