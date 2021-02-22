import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text("Sing IN"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                controller: user,
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
                    onPressed: () {},
                    child: Text("Sing In"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SingUp()));
                    },
                    child: Text("Sing Up"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
