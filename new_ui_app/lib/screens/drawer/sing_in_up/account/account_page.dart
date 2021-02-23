import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AccountPage();
  }
}

class _AccountPage extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        title: Text("My Account"),
      ),
      body: ListView(children: [
        Container(color: Colors.white,
        child: Text("My Order"),)
      ],),
    );
  }
}
