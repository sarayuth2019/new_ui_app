import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyShop extends StatefulWidget {
  MyShop(this.accountID);

  final accountID;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyShop(accountID);
  }
}

class _MyShop extends State {
  _MyShop(this.accountID);

  final accountID;
  final snackBarKey = GlobalKey<ScaffoldState>();
  final snackBarDelete = SnackBar(content: Text("Delete Success !"));
  final urlListItemByUser =
      "https://testheroku11111.herokuapp.com/Item/find/user";
  final urlDeleteProducts =
      "https://testheroku11111.herokuapp.com/Item/delete/";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listItemByUser();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: snackBarKey,
        body: Container(
          child: FutureBuilder(
            future: listItemByUser(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data.length == 0) {
                return Center(
                    child: Text(
                  "No Products",
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      child: Image.memory(
                                        base64Decode(
                                            snapshot.data[index].image),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshot.data[index].name}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "฿${snapshot.data[index].price}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                        ),
                                        Text("${snapshot.data[index].location}")
                                      ],
                                    )
                                  ],
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 120, right: 10),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.highlight_remove_outlined,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          print('Show Alert Dialog !');
                                          return showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'Delete Products ?',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                            child:
                                                                GestureDetector(
                                                                    child: Text(
                                                                        'Delete'),
                                                                    onTap: () {
                                                                      http
                                                                          .get(
                                                                              "${urlDeleteProducts}/${snapshot.data[index].id}")
                                                                          .then(
                                                                              (res) {
                                                                        var _jsonData =
                                                                            jsonDecode(
                                                                                res.body);
                                                                        var dataStatus =
                                                                            _jsonData[
                                                                                'status'];
                                                                        if (dataStatus == 0) {
                                                                          setState(() {
                                                                          });
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          snackBarKey
                                                                              .currentState
                                                                              .showSnackBar(snackBarDelete);
                                                                          print(
                                                                              "delete Success");
                                                                        } else {
                                                                          return "delete fall";
                                                                        }
                                                                      });
                                                                    })),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                            child:
                                                                GestureDetector(
                                                                    child: Text(
                                                                        'Cancel'),
                                                                    onTap: () {

                                                                      Navigator.of(context).pop();
                                                                    })),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        }),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    });
              }
            },
          ),
        ));
  }

  Future<List<_Item>> listItemByUser() async {
    Map params = Map();
    List<_Item> listItem = [];
    params['user'] = accountID.toString();
    await http.post(urlListItemByUser, body: params).then((res) {
      print("listItem By Account Success");
      Map _jsonRes = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      var _itemData = _jsonRes['data'];

      for (var i in _itemData) {
        _Item _item = _Item(
            i['id'],
            i['name'],
            i['description'],
            i['rating'],
            i['count_rating'],
            i['price'],
            i['location'],
            i['user_id'],
            i['date'],
            i['image']);
        listItem.insert(0, _item);
      }
    });
    print("Products By Account : ${listItem.length}");
    return listItem;
  }
}

class _Item {
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

  _Item(
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
