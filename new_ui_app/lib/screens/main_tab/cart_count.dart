import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartCount extends StatefulWidget {
  CartCount(this.accountID);

  final int accountID;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CartCount(accountID);
  }
}

class _CartCount extends State {
  _CartCount(this.accountID);

  final int accountID;
  final urlCartByCustomer =
      "https://testheroku11111.herokuapp.com/Cart/find/customer";
  int _countCart = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: streamCartCount(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        print("Stream snapshot :${snapshot.data}");
        if (snapshot.data == null) {
          return Container(
            height: 17,
            width: 17,
            child: Center(child: Text("?")),
          );
        } else {
          return Container(
              height: 17,
              width: 17,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(
                  "${_countCart.toString()}",
                  style: TextStyle(color: Colors.white),
                ),
              ));
        }
      },
    );

  }

  Stream <void> streamCartCount()async* {
    Future.delayed(Duration(seconds: 5));
    Map params = Map();
    params['customer'] = accountID.toString();
    print("Stream connect to Api Cart Customer Products...");
    var res = await http.post(urlCartByCustomer, body: params);
    print("Stream connect to Api Cart Customer Products Success");
    Map jsonData = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
    var productsData = jsonData['data'];
    if (productsData != null) {
      setState(() {
        _countCart = productsData.length;
        print("Stream Cart Count : ${_countCart.toString()}");
      });
    } else {
      print("Stream Cart Count null : ${productsData.length}");
    }
    yield _countCart;
  }
}
