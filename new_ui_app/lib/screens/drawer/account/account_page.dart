

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_ui_app/screens/drawer/account/my_shop_tab.dart';
import 'package:new_ui_app/screens/drawer/account/sell_products_tab.dart';

class AccountPage extends StatefulWidget {
  AccountPage(this.accountID);

  final accountID;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AccountPage(accountID);
  }
}

class _AccountPage extends State {
  _AccountPage(this.accountID);

  final accountID;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.orange[600],
          title: Text("My Account ID ${accountID.toString()}"),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text("ร้านของฉัน"),
              ),
              Tab(
                child: Text("ลงขายสินค้า"),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [MyShop(accountID), SellProducts(accountID)],
        ),
      ),
      initialIndex: 0,
      length: 2,
    );
  }
}
