import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyShop extends StatefulWidget {
  MyShop(this.accountID);

  final accountID;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyShop(accountID);
  }
}

class _MyShop extends State {
  _MyShop(this.accountID);

  final accountID;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Text("My Shop ID ${accountID.toString()}"),
    );
  }
}
