import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:new_ui_app/screens/main_tab/products_page.dart';

class AllProductsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AllProductsPage();
  }
}

class _AllProductsPage extends State {
  final urlListAllProducts = "https://testheroku11111.herokuapp.com/Item/list";

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
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductsPage(
                                      snapshot.data[index].id,
                                      snapshot.data[index].name,
                                      snapshot.data[index].description,
                                      snapshot.data[index].rating,
                                      snapshot.data[index].countRating,
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
                                        borderRadius: BorderRadius.circular(30),
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
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.memory(
                                          base64Decode(
                                              snapshot.data[index].image),
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      initialRating: snapshot.data[index].rating
                                          .toDouble(),
                                      itemBuilder: (context, r) {
                                        return Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber,
                                        );
                                      },
                                      itemSize: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "(${snapshot.data[index].rating})",
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
                                            "(${snapshot.data[index].countRating})",
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
                );
              }
            }));
  }

  Future<List<_Products>> _listProducts() async {
    print("connect to Api...");
    var _getDataProDucts = await http.get(urlListAllProducts);
    print("connect to Api Success");
    var _jsonDataAllProducts =
        jsonDecode(utf8.decode(_getDataProDucts.bodyBytes));
    var _dataAllProducts = _jsonDataAllProducts['data'];

    List<_Products> listAllProducts = [];
    for (var p in _dataAllProducts) {
      print("list data....");
      _Products _products = _Products(
          p['id'],
          p['name'],
          p['description'],
          p['rating'],
          p['count_rating'],
          p['price'],
          p['location'],
          p['user_id'],
          p['date'],
          p['image']);
      listAllProducts.insert(0,_products);
    }
    print("Products length : ${listAllProducts.length}");
    return listAllProducts;
  }
}

class _Products {
  final int id;
  final String name;
  final String description;
  final int rating;
  final int countRating;
  final int price;
  final String location;
  final int user_id;
  final String data;
  final String image;

  _Products(
    this.id,
    this.name,
    this.description,
    this.rating,
    this.countRating,
    this.price,
    this.location,
    this.user_id,
    this.data,
    this.image,
  );
}
