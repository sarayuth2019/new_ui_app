import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SingUp();
  }
}

class _SingUp extends State {
  final _formKey = GlobalKey<FormState>();
  final _snackBarKey = GlobalKey<ScaffoldState>();
  final singUpSnackBar =
      SnackBar(content: Text("Please wait a moment , Sing Up..."));
  bool _checkText = false;
  String email;
  String password;
  TextEditingController confirmPass = TextEditingController();
  String name;
  String surname;
  String number;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _snackBarKey,
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        title: Text("Sing Up"),
      ),
      body: SingleChildScrollView(
        child: Form(
          // ignore: deprecated_member_use
          autovalidate: _checkText,
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Email"),
                maxLength: 32,
                validator: validateEmail,
                onSaved: (String _text) {
                  email = _text;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
                maxLength: 12,
                obscureText: true,
                validator: validatePassword,
                controller: confirmPass,
                onSaved: (String _text) {
                  password = _text;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Confirm Password"),
                maxLength: 12,
                obscureText: true,
                validator: validateConfirmPassword,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Name"),
                maxLength: 32,
                validator: validateName,
                onSaved: (String _text) {
                  name = _text;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Surname"),
                maxLength: 32,
                validator: validateName,
                onSaved: (String _text) {
                  surname = _text;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(hintText: "เบอร์โทรติดต่อ"),
                validator: validateNumber,
                onSaved: (String _num) {
                  number = _num;
                },
              ),
              RaisedButton(
                color: Colors.orange[600],
                onPressed: onSingUp,
                child: Text(
                  "Sing up",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "กรุณากรอกอีเมล";
    } else if (!regExp.hasMatch(value)) {
      return "รูปแบบอีเมลไม่ถูกต้อง";
    }
    return null;
  }

  String validatePassword(String text) {
    if (text.length == 0) {
      return "กรุณากรอก Password";
    } else if (text.length < 6) {
      return "กรุณากรอก Password 6-12";
    } else if (text.length > 12) {
      return "กรุณากรอก Password 6-12 ตัว";
    } else {
      return null;
    }
  }

  String validateConfirmPassword(String text) {
    if (text.length == 0) {
      return "กรุณากรอก Confirm Password";
    } else if (text != confirmPass.text) {
      return "กรุณากรอก Password ให้ตรงกัน";
    } else {
      return null;
    }
  }

  String validateName(String text) {
    if (text.length == 0) {
      return "กรุณากรอกชื่อ";
    } else {
      return null;
    }
  }

  String validateSurName(String text) {
    if (text.length == 0) {
      return "กรุณากรอกนามสกุล";
    } else {
      return null;
    }
  }

  String validateNumber(String text) {
    String pattern = r'^[0-9]{10}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(text)) {
      return "กรุณากรอกเบอร์ติดต่อให้ถูกต้อง";
    } else {
      return null;
    }
  }

  void onSingUp() {
    if (_formKey.currentState.validate()) {
      _snackBarKey.currentState.showSnackBar(singUpSnackBar);
      _formKey.currentState.save();
      print(email);
      print(password);
      print(name);
      print(number);
    } else {
      setState(() {
        _checkText = true;
      });
    }
  }
}
