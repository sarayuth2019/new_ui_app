import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage(
      this.id,
      this.name,
      this.description,
      this.rating,
      this.countRating,
      this.price,
      this.location,
      this.user_id,
      this.data,
      this.image);

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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductsPage(id, name, description, rating, countRating, price,
        location, user_id, data, image);
  }
}

class _ProductsPage extends State {
  _ProductsPage(
      this.id,
      this.name,
      this.description,
      this.rating,
      this.countRating,
      this.price,
      this.location,
      this.user_id,
      this.data,
      this.image);

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
  int number = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        title: Text("Products ID : ${id}"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {}),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            height: 300,
            child: image == null
                ? Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        color: Colors.blueGrey,
                        height: 200,
                        width: 200,
                        child: Icon(
                          Icons.image_outlined,
                          color: Colors.orange[600],
                          size: 70,
                        ),
                      ),
                    ),
                  )
                : Image.memory(
                    base64Decode(image),
                    fit: BoxFit.fill,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${name.toString()}",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          Text("${location.toString()}")
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${rating.toString()}",
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RatingBar.builder(
                            ignoreGestures: true,
                            allowHalfRating: true,
                            itemCount: 5,
                            initialRating: rating.toDouble(),
                            itemBuilder: (context, r) {
                              return Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                              );
                            },
                            itemSize: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "(${countRating.toString()}) ratings",
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          )
                        ],
                      ),
                      Text(
                        "฿${price*number}",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${description.toString()}",
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.blue,
                                size: 30,
                              ),
                              onPressed: () {
                                if (number == 1) {
                                  number = 1;
                                } else {
                                  setState(() {
                                    number--;
                                  });
                                }
                                print(number);
                              }),
                          Text(
                            "${number.toString()}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Colors.blue,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  number++;
                                });
                                print(number);
                              }),
                        ],
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 40,
                                width: 150,
                                color: Colors.orange[600],
                                child: Center(
                                    child: Text(
                                  "Add to cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
