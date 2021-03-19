import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final urlMyOrder = "https://testheroku11111.herokuapp.com/Order/find/user";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder(
        future: futureListMyOrder(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data.length == 0) {
            return Center(
                child: Text(
              "No have order",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                      child: Row(
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.memory(
                              base64Decode(snapshot.data[index].image),
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text("PID : ${snapshot.data[index].item_id}")
                        ],
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "${snapshot.data[index].name}",
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text("${snapshot.data[index].data}"),
                          trailing: Column(
                            children: [
                              Text("จำนวน ${snapshot.data[index].number}"),
                              Text(
                                  "ราคา ฿${snapshot.data[index].number * snapshot.data[index].price} "),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ));
                });
          }
        },
      ),
    );
  }

  Future<List<_Order>> futureListMyOrder() async {
    Map params = Map();
    List<_Order> listOrderByAccount = [];
    params['user'] = accountID.toString();
    print("connect to Api Order by Account...");
    await http.post(urlMyOrder, body: params).then((res) {
      print("connect to Api Order by Account Success");
      Map jsonData = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      var productsData = jsonData['data'];

      for (var p in productsData) {
        print("list Order products...");
        _Order _order = _Order(
            p['id'],
            p['status'],
            p['name'],
            p['number'],
            p['price'],
            p['customer'],
            p['user'],
            p['item'],
            p['date'],
            p['image']);
        listOrderByAccount.add(_order);
      }
    });
    print("Order Products length : ${listOrderByAccount.length}");
    return listOrderByAccount;
  }
}

class _Order {
  final int id;
  final int status;
  final String name;
  final int number;
  final int price;
  final int customer_id;
  final int seller_id;
  final int item_id;
  final String data;
  final String image;

  _Order(
    this.id,
    this.status,
    this.name,
    this.number,
    this.price,
    this.customer_id,
    this.seller_id,
    this.item_id,
    this.data,
    this.image,
  );
}
