import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:order_up_merchant/commons/enums/enum_status.dart';
import 'package:order_up_merchant/commons/models/order.dart';

class OrderDetails extends StatefulWidget {
  final Order order;

  OrderDetails(this.order);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Order _order;

  @override
  void initState() {
    super.initState();
    _order = widget.order;
    _order.items = _order.items ?? [];
  }

  @override
  Widget build(BuildContext context) {
    var user = _order.user;
    return SafeArea(
      child: Scaffold(
        bottomSheet: ButtonBar(
          buttonPadding: EdgeInsets.symmetric(horizontal: 15),
          alignment: MainAxisAlignment.center,
          children: _getButtons(_order.status),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _getTextField(FontAwesome.user,
                            '${user.firstName} ${user.lastName}'),
                        _getTextField(FontAwesome5Solid.store, '${user.store}'),
                      ],
                    ),
                    _getTextField(FontAwesome.map_pin, user.location),
                    _getTextField(FontAwesome.phone, user.contactNo),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [Text('Total: '), Text('${_order.total}')],
                        ),
                        Row(
                          children: [
                            Text('Status: '),
                            Text('${_order.status}')
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [Text('Paid: '), Text('${_getAmountPaid()}')],
                    ),
                    Row(
                      children: [Text('Balance: '), Text('${_getBalance()}')],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Quantity'), numeric: true),
                  DataColumn(label: Text('Package')),
                  DataColumn(label: Text('Price'), numeric: true),
                ],
                rows: List.generate(_order.items.length, (index) {
                  var item = _order.items[index];
                  return DataRow.byIndex(index: index, cells: [
                    DataCell(Text(item.name)),
                    DataCell(Text('${item.quantity}')),
                    DataCell(Text(item.package)),
                    DataCell(Text('${item.price}')),
                  ]);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTextField(IconData iconData, String value) {
    return Row(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: Icon(
              iconData,
              size: 18,
            )),
        Text(
          '$value',
          style: TextStyle(
              letterSpacing: 1, fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  List<Widget> _getButtons(String status) {
    List<Widget> buttons = [];

    if (status == Status.PENDING) {
      buttons.addAll([
        MaterialButton(
          child: Text('Accept'),
          onPressed: () {
            _updateOrderStatus(Status.PROCESSING);
          },
        ),
        MaterialButton(
          child: Text('Decline'),
          onPressed: () {
            _updateOrderStatus(Status.CANCELLED);
          },
        )
      ]);
    }

    if (status == Status.PROCESSING) {
      buttons.add(MaterialButton(
        child: Text('Deliver'),
        onPressed: () {
          _updateOrderStatus(Status.FOR_DELIVERY);
        },
      ));
    }

    if (status == Status.FOR_DELIVERY) {
      buttons.add(MaterialButton(
        child: Text('Delivered'),
        onPressed: () {
          _updateOrderStatus(Status.DELIVERED);
        },
      ));
    }

    if (status == Status.DELIVERED || status == Status.PARTIAL_PAID) {
      buttons.addAll([
        MaterialButton(
          child: Text('Full Payment'),
          onPressed: () {
            _updateOrderStatus(Status.PAID);
          },
        ),
        MaterialButton(
          child: Text('Partial Payment'),
          onPressed: () {
            _updateOrderStatus(Status.PARTIAL_PAID);
          },
        )
      ]);
    }
    return buttons;
  }

  void _updateOrderStatus(String statusEnum) {
    setState(() => _order.status = statusEnum);
  }

  double _getAmountPaid() {
    if(_order.payments != null ) {
      return _order.payments.fold(0.0, (previousValue, element) => previousValue + element.amountPaid);
    }
    return 0.0;
  }

  double _getBalance() {
    var payments = _order.payments;
    if(payments != null && payments.isNotEmpty) {
      return payments.last.balance;
    }
    return 0.0;
  }
}
