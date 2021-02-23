import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_ui_app/screens/drawer/sing_in_up/account/account_page.dart';
import 'package:new_ui_app/screens/drawer/sing_in_up/sing_up_page.dart';



class SingIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SingIn();
  }
}

class _SingIn extends State {
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        title: Text("Sing IN"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.orange[600],
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.location_searching,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.shopping_cart,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
                child: ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: TextField(
                controller: user,
                decoration: InputDecoration(
                    hintText: "Username", border: InputBorder.none),
              ),
            )),
            Card(
                child: ListTile(
              leading: Icon(Icons.vpn_key_outlined),
              title: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password", border: InputBorder.none),
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Colors.orange[600],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountPage()));
                    },
                    child: Text(
                      "Sing In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Colors.orange[600],
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SingUp()));
                    },
                    child: Text(
                      "Sing Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
