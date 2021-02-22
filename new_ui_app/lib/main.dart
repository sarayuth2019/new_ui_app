import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_ui_app/screens/appBar/cart/cart_page.dart';
import 'package:new_ui_app/screens/appBar/promotion/promotion_page.dart';
import 'package:new_ui_app/screens/appBar/search/search_page.dart';
import 'package:new_ui_app/screens/drawer/food_drink/food_drink_page.dart';
import 'package:new_ui_app/screens/drawer/location/location_page.dart';
import 'package:new_ui_app/screens/drawer/school_supplies/school_supplies_page.dart';
import 'package:new_ui_app/screens/drawer/sing_in_up/sing_in_page.dart';
import 'package:new_ui_app/screens/drawer/uniform/uniform_page.dart';
import 'package:new_ui_app/screens/tab/all_deals.dart';
import 'package:new_ui_app/screens/tab/all_goods.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State {
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
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  }),
              IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage()));
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
                  text: "All Goods",
                ),
                Tab(
                  text: "All Deals",
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: Container(
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
                          child: Text(
                            "Hello",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingIn()));
                          },
                          child: Card(
                            color: Colors.orange[600],
                            child: ListTile(
                              leading: Icon(
                                Icons.account_circle_outlined,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Sing in',
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
                                Icons.location_on_outlined,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartPage()));
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
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                        onTap: () {},
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
            children: [AllGoodsPage(), AllDealsPage()],
          )),
      initialIndex: 0,
      length: 2,
    );
  }
}
