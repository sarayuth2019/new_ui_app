import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  CartPage(this.accountID);

  final accountID;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CartPage(accountID);
  }
}

class _CartPage extends State {
  _CartPage(this.accountID);

  final accountID;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(backgroundColor: Colors.orange[600],
        title: Text("My Cart ID ${accountID.toString()}"),
      ),
      body: Container(
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
