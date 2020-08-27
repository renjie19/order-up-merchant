import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:order_up_merchant/commons/models/account.dart';
import 'package:order_up_merchant/commons/models/order.dart';
import 'package:order_up_merchant/commons/models/user.dart';
import 'package:order_up_merchant/commons/utils/order_util.dart';
import 'package:order_up_merchant/commons/utils/user_util.dart';
import 'package:order_up_merchant/services/auth/auth_service.dart';
import 'package:order_up_merchant/services/auth/fire_base_auth.dart';

class FirestoreService {
  final CollectionReference _merchantCollection =
      Firestore.instance.collection('MERCHANTS');
  final CollectionReference _orderCollection =
      Firestore.instance.collection('ORDERS');

  final AuthService _authService = GetIt.I<FireBaseAuth>();

  /// ACCOUNT

  Future<Account> create(Account account, password) async {
    AuthResult result = await _authService.signUp(account.user.email, password);
    if (result != null) {
      account.user.id = result.user.uid;
      var document = _merchantCollection.document(account.user.id);
      await document.setData(UserUtil.toMap(account.user));
    }
    return account;
  }

  Future<Account> update(Account account) async {
    var document = _merchantCollection.document(account.user.id);
    await document.updateData(UserUtil.toMap(account.user));
    return account;
  }

  Future<Account> getAccount(String id) async {
    Account account = Account();
    DocumentSnapshot documentSnapshot =
        await _merchantCollection.document(id).get();

    if (documentSnapshot.exists) {
      account.user = UserUtil.toEntity(documentSnapshot.data);
      account.orders = findOrdersByMerchant(id) ?? [];
    }
    return account;
  }

  /// ORDERS

  Future<Order> updateOrder(Order order) async {
    await _orderCollection
        .document(order.id)
        .updateData(OrderUtil.toMap(order));
    return order;
  }

  Future<List<Order>> findOrdersByMerchant(String id) async {
    QuerySnapshot orderDocuments = await _orderCollection
        .where('merchantId', isEqualTo: id)
        .getDocuments();

    return OrderUtil.documentsToEntities(orderDocuments.documents);
  }

  Future<Order> findOrder(String id) async {
    return OrderUtil.documentToEntity(
        await _orderCollection.document(id).get());
  }

  Stream<List<Order>> orderUpdates(String id) {
    return _orderCollection
        .where('merchantId', isEqualTo: id)
        .getDocuments()
        .asStream()
        .asyncMap((event) => OrderUtil.documentsToEntities(event.documents));
  }
}
