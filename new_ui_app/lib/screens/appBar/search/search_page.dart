
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_ui_app/screens/appBar/search/search_location_tab.dart';
import 'package:new_ui_app/screens/appBar/search/search_nameProducts_tab.dart';


class SearchPage extends StatefulWidget {
  SearchPage(this.accountID);
  final int accountID;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchPage(accountID);
  }
}

class _SearchPage extends State {
  _SearchPage(this.accountID);
  final int accountID;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.orange[600],
          title: Text("Search"),
          bottom: TabBar(tabs: [
            Tab(
              child: Row(
                children: [
                  Icon(Icons.search),
                  Text("Search Products"),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  Text("Search Location"),
                ],
              ),
            ),
          ]),
        ),
        body: TabBarView(children: [SearchNameProducts(accountID), SearchLocation(accountID)]),
      ),
      initialIndex: 0,
      length: 2,
    );
  }
}