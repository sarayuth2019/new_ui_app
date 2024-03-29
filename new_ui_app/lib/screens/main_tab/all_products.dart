import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:new_ui_app/screens/main_tab/products_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllProductsPage extends StatefulWidget {
  AllProductsPage();


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AllProductsPage();
  }
}

class _AllProductsPage extends State {
  _AllProductsPage();

  int accountID;
  final urlListAllProducts = "https://testheroku11111.herokuapp.com/Item/list";
  int ratingCount = 10;
  double rating = 3.9;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccountID();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: FutureBuilder(
            future: _listProducts(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductsPage(
                                        accountID,
                                        snapshot.data[index].id,
                                        snapshot.data[index].name,
                                        snapshot.data[index].description,
                                        rating,
                                        ratingCount,
                                        snapshot.data[index].price,
                                        snapshot.data[index].location,
                                        snapshot.data[index].user_id,
                                        snapshot.data[index].data,
                                        snapshot.data[index].image,
                                      )));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: snapshot.data[index].image == null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                              color: Colors.blueGrey,
                                              height: 200,
                                              width: 200,
                                              child: Icon(
                                                Icons.image_outlined,
                                                color: Colors.orange[600],
                                                size: 40,
                                              )),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                            height: 200,
                                            width: 200,
                                            child: Image.memory(
                                              base64Decode(
                                                  snapshot.data[index].image),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${snapshot.data[index].name}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "฿${snapshot.data[index].price}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      RatingBar.builder(
                                        ignoreGestures: true,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        initialRating:
                                            rating,
                                        itemBuilder: (context, r) {
                                          return Icon(
                                            Icons.star_rounded,
                                            color: Colors.amber,
                                          );
                                        },
                                        itemSize: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "(${rating.toString()})",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.supervisor_account,
                                              color: Colors.blue,
                                            ),
                                            Text(
                                              "(${ratingCount.toString()})",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                            ),
                                            Text(
                                                "${snapshot.data[index].location}")
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }));
  }

  Future<void> _onRefresh() async {
    getAccountID();
    setState(() {});
    await Future.delayed(Duration(seconds: 3));
  }

  Future<List<_Products>> _listProducts() async {
    print("connect to Api All Products...");
    var _getDataProDucts = await http.get(urlListAllProducts);
    print("connect to Api All Products Success");
    var _jsonDataAllProducts =
        jsonDecode(utf8.decode(_getDataProDucts.bodyBytes));
    var _dataAllProducts = _jsonDataAllProducts['data'];
    List<_Products> listAllProducts = [];
    for (var p in _dataAllProducts) {
      _Products _products = _Products(
          p['id'],
          p['name'],
          p['description'],
          p['price'],
          p['location'],
          p['user'],
          p['date'],
          p['image']);
      listAllProducts.insert(0, _products);
    }
    print("All Products length : ${listAllProducts.length}");
    return listAllProducts;
  }

  Future getAccountID() async {
    final SharedPreferences _accountID = await SharedPreferences.getInstance();
    final accountIDInDevice = _accountID.getInt('accountID');
    if (accountIDInDevice != null) {
      setState(() {
        accountID = accountIDInDevice;
        print("Get account login future: accountID ${accountID.toString()}");
      });
    }
    else{print("no have accountID login");}
  }

}


class _Products {
  final int id;
  final String name;
  final String description;
  final int price;
  final String location;
  final int user_id;
  final String data;
  final String image;

  _Products(
    this.id,
    this.name,
    this.description,
    this.price,
    this.location,
    this.user_id,
    this.data,
    this.image,
  );
}
