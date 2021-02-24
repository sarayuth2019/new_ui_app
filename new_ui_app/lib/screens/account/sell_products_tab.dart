import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class SellProducts extends StatefulWidget {
  SellProducts(this.accountID);

  final accountID;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SellProducts(accountID);
  }
}

class _SellProducts extends State {
  _SellProducts(this.accountID);

  final accountID;
  final _formKey = GlobalKey<FormState>();
  final _snackBarKey = GlobalKey<ScaffoldState>();
  final urlSellProducts = "https://testheroku11111.herokuapp.com/Item/save";
  final snackBarOnSave =
      SnackBar(content: Text("กำลังขายลงขาย กรุณารอซักครู่..."));
  final snackBarOnSaveSuccess = SnackBar(content: Text("ลงขายสินค้า สำเร็จ !"));
  final snackBarSaveFail = SnackBar(content: Text("ลงขายสินค้า ล้มเหลว !"));
  bool checkText = false;
  String nameMenu;
  int price;
  File imageFile;
  var imageData;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _snackBarKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          // ignore: deprecated_member_use
          autovalidate: checkText,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "ID ${accountID.toString()}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _showAlertSelectImage(context);
                    },
                    child: Container(
                      child: imageData == null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 200,
                                width: 200,
                                color: Colors.grey,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                child: Image.memory(
                                  base64Decode(imageData),
                                  fit: BoxFit.fill,
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                            ),
                    ),
                  )),
              TextFormField(
                decoration: InputDecoration(hintText: "ชื่อสินค้า"),
                validator: _checkText,
                onSaved: (text) {
                  nameMenu = text;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "ราคาสินค้า : บาท"),
                keyboardType: TextInputType.number,
                validator: _checkPrice,
                onSaved: (num) {
                  price = int.parse(num);
                },
              ),
              RaisedButton(
                  color: Colors.orange[600],
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: onSaveData)
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertSelectImage(BuildContext context) async {
    print('Show Alert Dialog Image !');
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Choice'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: GestureDetector(
                          child: Text('Gallery'), onTap: _onGallery)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: GestureDetector(
                          child: Text('Camera'), onTap: _onCamera)),
                ],
              ),
            ),
          );
        });
  }

  _onGallery() async {
    print('Select Gallery');
    // ignore: deprecated_member_use
    var _imageGallery =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (_imageGallery != null) {
      setState(() {
        imageFile = File(_imageGallery.path);
      });
      imageData = base64Encode(imageFile.readAsBytesSync());
      return imageData;
    } else {
      return null;
    }
  }

  _onCamera() async {
    print('Select Camera');
    // ignore: deprecated_member_use
    var _imageGallery =
        await ImagePicker().getImage(source: ImageSource.camera);
    if (_imageGallery != null) {
      setState(() {
        imageFile = File(_imageGallery.path);
      });
      imageData = base64Encode(imageFile.readAsBytesSync());
      return imageData;
    } else {
      return null;
    }
  }

  String _checkText(text) {
    if (text.length == 0) {
      return "กรุณาใส่ชื่อสินค้า";
    } else {
      return null;
    }
  }

  String _checkPrice(text) {
    if (text.length == 0) {
      return "กรุณาใส่ราคาสินค้า";
    } else {
      return null;
    }
  }

  void onSaveData() {
    _snackBarKey.currentState.showSnackBar(snackBarOnSave);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("account Id ${accountID}");
      print(nameMenu);
      print(price);
      saveToDB();
    } else {
      setState(() {
        checkText = true;
      });
    }
  }

  void saveToDB() {
    Map params = Map();
    params['user_id'] = accountID.toString();
    params['name'] = nameMenu.toString();
    params['price'] = price.toString();
    params['image'] = imageData.toString();
    http.post(urlSellProducts, body: params).then((res) {
      Map _resData = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      print(_resData);
      var _resStatus = _resData['status'];
      setState(() {
        if (_resStatus == 0) {
          _snackBarKey.currentState.showSnackBar(snackBarOnSaveSuccess);
        } else {
          _snackBarKey.currentState.showSnackBar(snackBarSaveFail);
        }
      });
    });
  }
}
