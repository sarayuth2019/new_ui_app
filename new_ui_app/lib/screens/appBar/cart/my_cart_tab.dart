import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class MyCartTab extends StatefulWidget {
  MyCartTab(this.accountID);

  final int accountID;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyCartTab(accountID);
  }
}

class _MyCartTab extends State {
  _MyCartTab(this.accountID);

  final int accountID;
  final urlCartByCustomer = "https://testheroku11111.herokuapp.com/Cart/find/customer";
  final urlSaveToOrder = "https://testheroku11111.herokuapp.com/Order/save";
  final urlDeleteProductInCart = "https://testheroku11111.herokuapp.com/Cart/delete/";
  final snackBarKey = GlobalKey<ScaffoldState>();
  final snackBarOnDelete = SnackBar(content: Text("กำลังลบสินค้า..."));
  final snackBarOnDeleteSuccess = SnackBar(content: Text("กำลังลบสินค้า สำเร็จ !"));
  final snackBarDeleteFall = SnackBar(content: Text("ผิดพลาด ! กรุณาลองใหม่อีกครั้ง"));
  final snackBarSaveToOrder = SnackBar(content: Text("กรุณารอซักครู่ กำลังสั่งซื้อ..."));
  final snackBarSaveToOrderSuccess = SnackBar(content: Text("สั่งซื้อสำเร็จ !"));
  final snackBarSaveToOrderFall = SnackBar(content: Text("สั่งซื้อผิดพลาด กรุณาลองใหม่อีกครั้ง !"));
  List _listProductsByCustomer = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: snackBarKey,
      backgroundColor: Colors.blueGrey,
      body: FutureBuilder(
          future: listCartByCustomer(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, index) {
                          return Card(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.memory(
                                        base64Decode(
                                            snapshot.data[index].image),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Expanded(
                                  child: ListTile(
                                    trailing: IconButton(
                                      onPressed: () {
                                        snackBarKey.currentState
                                            .showSnackBar(snackBarOnDelete);
                                        http
                                            .get(
                                                "${urlDeleteProductInCart}${snapshot.data[index].id}")
                                            .then((res) {
                                          var jsonData = jsonDecode(res.body);
                                          var statusData = jsonData['status'];
                                          print(statusData);
                                          if (statusData == 0) {
                                            snackBarKey.currentState
                                                .showSnackBar(
                                                    snackBarOnDeleteSuccess);
                                            setState(() {});
                                          } else {
                                            snackBarKey.currentState
                                                .showSnackBar(
                                                    snackBarDeleteFall);
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${snapshot.data[index].name}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "฿${snapshot.data[index].price} x ${snapshot.data[index].number}"),
                                        Text(
                                            "รวมเป็นเงิน  ${snapshot.data[index].number * snapshot.data[index].price}  บาท")
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "ราคาสินค้าทั้งหมด : ฿${snapshot.data.length > 0 ? snapshot.data.map((_snapshot) => _snapshot.price * _snapshot.number).reduce((value, element) => value + element).toString() : 0}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: saveToOrder,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(1),
                              child: Container(
                                  width: 110,
                                  color: Colors.orange[600],
                                  child: Center(
                                    child: Text(
                                      "สั่งซื้อ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
          }),
    );
  }

  Future<List<_Products>> listCartByCustomer() async {
    Map params = Map();
    List<_Products> listProductsByCustomer = [];
    params['customer'] = accountID.toString();
    print("connect to Api Cart Customer Products...");
    await http.post(urlCartByCustomer, body: params).then((res) {
      print("connect to Api Cart Customer Products Success");

      Map jsonData = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      var productsData = jsonData['data'];

      for (var p in productsData) {
        print("list Cart products...");
        _Products _products = _Products(
            p['id'],
            p['status'],
            p['name'],
            p['number'],
            p['price'],
            p['customer'],
            p['user'],
            p['date'],
            p['image']);
        listProductsByCustomer.add(_products);
      }
    });
    print("Cart Products length : ${listProductsByCustomer.length}");
    _listProductsByCustomer = listProductsByCustomer;
    return listProductsByCustomer;
  }

  void saveToOrder() {
    snackBarKey.currentState.showSnackBar(snackBarSaveToOrder);
    print("Save to Order...");
    _listProductsByCustomer.forEach((element) {
      Map params = Map();
      params['name'] = element.name.toString();
      params['number'] = element.number.toString();
      params['price'] = element.price.toString();
      params['customer'] = element.customer_id.toString();
      params['user'] = element.seller_id.toString();
      params['image'] = element.image.toString();
      http.post(urlSaveToOrder, body: params).then((res) {
        print(res.body);
        Map jsonData = jsonDecode(res.body);
        var statusData = jsonData['status'];
        if(statusData==1){
          snackBarKey.currentState.showSnackBar(snackBarSaveToOrderSuccess);
        }else{
          snackBarKey.currentState.showSnackBar(snackBarSaveToOrderFall);
        }
      });
    });
    print("Order length : ${_listProductsByCustomer.length}");
  }
}

class _Products {
  final int id;
  final int status;
  final String name;
  final int number;
  final int price;
  final int customer_id;
  final int seller_id;
  final String data;
  final String image;

  _Products(
    this.id,
    this.status,
    this.name,
    this.number,
    this.price,
    this.customer_id,
    this.seller_id,
    this.data,
    this.image,
  );
}
