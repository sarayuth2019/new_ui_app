import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllGoodsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AllGoodsPage();
  }
}

class _AllGoodsPage extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "All Goods",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [Text("Goods 1"), Text("Goods 2")],
      ),
    );
  }
}
