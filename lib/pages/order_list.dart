import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:order_up_merchant/commons/models/order.dart';
import 'package:order_up_merchant/commons/utils/order_util.dart';
import 'package:order_up_merchant/commons/utils/user_tracker.dart';
import 'package:order_up_merchant/pages/order_details.dart';
import 'package:order_up_merchant/services/order/order_service.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final OrderService _orderService = GetIt.I<OrderService>();
  final UserTracker _userTracker = GetIt.I<UserTracker>();
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _orderService
        .findOrders()
        .then((value) => setState(() => _orders = value ?? []));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: _orders,
        stream: _orderService.listenToChanges,
        builder: (context, orders) {
          _orders = orders.data;
          return Scaffold(
            body: Container(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Card(
                  child: DataTable(
                    showCheckboxColumn: false,
                    columns: [
                      DataColumn(
                        label: Text('Date'),
                      ),
                      DataColumn(
                        label: Text('Name'),
                      ),
                      DataColumn(
                        label: Text('Status'),
                      )
                    ],
                    rows: List.generate(_orders.length, (index) {
                      var order = _orders[index];
                      return DataRow(
                          onSelectChanged: (val) => _loadOrderInfoPage(order),
                          cells: [
                            DataCell(Text('${order.dateCreated}')),
                            DataCell(Text('${order.user.firstName} ${order.user.lastName}')),
                            DataCell(Text('${order.status}')),
                          ]);
                    }),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _loadOrderInfoPage(Order order) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OrderDetails(order);
    }));
  }
}
