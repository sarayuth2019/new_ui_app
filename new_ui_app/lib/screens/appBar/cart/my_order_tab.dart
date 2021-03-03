import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyOrderTab extends StatefulWidget {
  MyOrderTab(this.accountID);

  final int accountID;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyOrderTab(accountID);
  }
}

class _MyOrderTab extends State {
  _MyOrderTab(this.accountID);

  final int accountID;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.brown,
    );
  }
}
