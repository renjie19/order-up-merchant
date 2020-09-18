import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:order_up_merchant/commons/utils/user_tracker.dart';
import 'package:order_up_merchant/pages/login.dart';
import 'package:order_up_merchant/pages/start_page.dart';
import 'package:order_up_merchant/provider/auth_provider/auth_provider.dart';
import 'package:order_up_merchant/provider/order/order_list_provider.dart';
import 'package:order_up_merchant/services/account/account_service.dart';
import 'package:order_up_merchant/services/auth/fire_base_auth.dart';
import 'package:order_up_merchant/services/firestore/firestore_service.dart';
import 'package:order_up_merchant/services/order/order_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    GetIt.I.registerSingleton<UserTracker>(UserTracker());
    GetIt.I.registerSingleton<FireBaseAuth>(FireBaseAuth());
    GetIt.I.registerSingleton<FirestoreService>(FirestoreService());
    GetIt.I.registerSingleton<OrderService>(OrderService());
    GetIt.I.registerSingleton<AuthProvider>(AuthProvider());
    GetIt.I.registerSingleton<OrderListProvider>(OrderListProvider());
    GetIt.I.registerSingleton<AccountService>(AccountService());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GetIt.I<AuthProvider>(),)
        ],
        child: Wrapper());
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.watch<AuthProvider>().userId == null ? Login() : StartPage();
  }
}

