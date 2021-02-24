import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage(this.id);

  final int id;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductsPage(id);
  }
}

class _ProductsPage extends State {
  _ProductsPage(this.id);

  final int id;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        title: Text("Products ID : ${id}"),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            height: 300,
          ),
          Container(),
        ],
      ),
    );
  }
}
