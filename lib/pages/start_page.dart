import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:order_up_merchant/commons/utils/user_tracker.dart';
import 'package:order_up_merchant/pages/account_management.dart';
import 'package:order_up_merchant/pages/order_list.dart';
import 'package:order_up_merchant/services/auth/auth_service.dart';
import 'package:order_up_merchant/services/auth/fire_base_auth.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final AuthService _authService = GetIt.I<FireBaseAuth>();
  final UserTracker _userTracker = GetIt.I<UserTracker>();
  final List<Map<String, Object>> tabs = [
    {'label': 'Tab1', 'page': Container()},
    {'label': 'Tab2', 'page': OrderList()}
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order Up Merchant'),
          leading: IconButton(
            icon: Icon(FontAwesome.user),
            onPressed: () => _loadAccountManagement(),
          ),
          actions: [
            IconButton(
              icon: Icon(FontAwesome.sign_out),
              onPressed: () => _authService.signOut(),
            )
          ],
          bottom: TabBar(
            tabs: tabs.map((e) => Tab(text: e['label'],)).toList(),
          ),
        ),
        body: TabBarView(
          children: tabs.map((e) => e['page']).toList().cast<Widget>(),
        ),
      ),
    );
  }

  void _loadAccountManagement() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return AccountManagement();
      }
    ));
  }
}
