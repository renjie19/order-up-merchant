import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:order_up_merchant/provider/auth_provider/auth_provider.dart';
import 'package:order_up_merchant/provider/order/order_list_provider.dart';
import 'package:order_up_merchant/services/auth/fire_base_auth.dart';
import 'package:order_up_merchant/services/firestore/firestore_service.dart';
import 'package:order_up_merchant/services/order/order_service.dart';
import 'package:provider/provider.dart';

import 'commons/utils/user_tracker.dart';
import 'pages/home.dart';

void main() {
  runApp(OrderUpMerchant());
}

class OrderUpMerchant extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order-Up Merchant',
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red[700],
        accentColor: Colors.redAccent,
        accentColorBrightness: Brightness.dark,
      ),
      home: Home(),
    );
  }
}