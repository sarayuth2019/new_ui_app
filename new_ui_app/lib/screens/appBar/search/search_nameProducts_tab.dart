import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_ui_app/screens/main_tab/products_page.dart';

class SearchNameProducts extends StatefulWidget {
  SearchNameProducts(this.accountID);
  final int accountID;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchNameProducts(accountID);
  }
}

class _SearchNameProducts extends State {
  _SearchNameProducts(this.accountID);
  final int accountID;

  final urlListAllProducts = "https://testheroku11111.herokuapp.com/Item/list";
  List _listAllProducts = [];
  List _searchProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listProducts().then((value) {
      setState(() {
        _listAllProducts = value;
        _searchProducts = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Card(
            child: TextField(
              decoration: InputDecoration(hintText: "   Enter product"),
              onChanged: (textSearch) {
                setState(() {
                  _searchProducts = _listAllProducts
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(textSearch.toLowerCase())).toList();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _searchProducts.length,
                itemBuilder: (BuildContext context, index) {
                  if (_searchProducts == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsPage(
                            accountID,
                            _searchProducts[index].id,
                            _searchProducts[index].name,
                            _searchProducts[index].description,
                            _searchProducts[index].rating,
                            _searchProducts[index].countRating,
                            _searchProducts[index].price,
                            _searchProducts[index].location,
                            _searchProducts[index].user_id,
                            _searchProducts[index].data,
                            _searchProducts[index].image)));
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.memory(
                                  base64Decode(_searchProducts[index].image),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "${_searchProducts[index].name}",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      "${_searchProducts[index].location}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    );
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
      listAllProducts.add(_products);
    }
    print("Home All Products length : ${listAllProducts.length}");
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
