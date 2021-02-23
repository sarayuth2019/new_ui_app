import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllDealsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AllDealsPage();
  }
}

class _AllDealsPage extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "All Deals",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [Text("Deals 1"), Text("Deals 2")],
      ),
    );
  }
}
