import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() {
  runApp(OrderUpMerchant());
}

class OrderUpMerchant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}