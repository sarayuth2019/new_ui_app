import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_ui_app/screens/appBar/cart/cart_page.dart';
import 'package:new_ui_app/screens/appBar/promotion/promotion_page.dart';
import 'package:new_ui_app/screens/appBar/search/search_page.dart';
import 'package:new_ui_app/screens/drawer/account/account_page.dart';
import 'package:new_ui_app/screens/drawer/food_drink/food_drink_page.dart';
import 'package:new_ui_app/screens/drawer/location/location_page.dart';
import 'package:new_ui_app/screens/drawer/school_supplies/school_supplies_page.dart';
import 'package:new_ui_app/screens/drawer/sing_in_up/sing_in_page.dart';
import 'package:new_ui_app/screens/drawer/uniform/uniform_page.dart';
import 'package:new_ui_app/screens/main_tab/all_deals.dart';
import 'package:new_ui_app/screens/main_tab/all_products.dart';


void main() => runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: HomePage(null)));

class HomePage extends StatefulWidget {
  HomePage(this.accountID);

  final accountID;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage(accountID);
  }
}

class _HomePage extends State {
  _HomePage(this.accountID);

  final accountID;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange[600],
            title: Text("RMUTI SHOP"),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage(accountID)));
                  }),
              IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    accountID == null
                        ? Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SingIn()))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage(accountID)));
                  }),
              IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PromotionPage()));
                  }),
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "All Products",
                ),
                Tab(
                  text: "All Deals",
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: Container(
              color: Colors.blueGrey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: accountID == null
                                ? Text(
                                    "Hello",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "Hello ID ${accountID.toString()}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                        GestureDetector(
                          onTap: () {
                            accountID == null
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingIn()))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AccountPage(accountID)));
                          },
                          child: Card(
                            color: Colors.orange[600],
                            child: ListTile(
                              leading: Icon(
                                Icons.account_circle,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Account',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationPage()));
                          },
                          child: Card(
                            color: Colors.orange[600],
                            child: ListTile(
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Location',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            accountID == null
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingIn()))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CartPage(accountID)));
                          },
                          child: Card(
                            color: Colors.orange[600],
                            child: ListTile(
                              leading: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Cart',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Popular Categories",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FoodAndDrinkPage()));
                          },
                          child: Card(
                            color: Colors.orange[600],
                            child: ListTile(
                              leading: Icon(
                                Icons.fastfood_outlined,
                                color: Colors.white,
                              ),
                              title: Text(
                                "Food & Drink",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SchoolSuppliesPage()));
                          },
                          child: Card(
                            color: Colors.orange[600],
                            child: ListTile(
                              leading: Icon(
                                Icons.work,
                                color: Colors.white,
                              ),
                              title: Text(
                                "School supplies",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UniformPage()));
                          },
                          child: Card(
                            color: Colors.orange[600],
                            child: ListTile(
                              leading: Icon(
                                Icons.wc_outlined,
                                color: Colors.white,
                              ),
                              title: Text(
                                "Uniform",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(null)),
                              (route) => false);
                        },
                        child: Card(
                          color: Colors.orange[600],
                          child: ListTile(
                            leading: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [AllProductsPage(accountID), AllDealsPage(accountID)],
          )),
      initialIndex: 0,
      length: 2,
    );
  }
}
