import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import './home_user.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usr = new TextEditingController();
  TextEditingController psw = new TextEditingController();
  String msg = '';

  Future<List> _login() async {
    final response = await http.post(
        'http://192.168.43.63/apiflutter/api/Login/login_api',
        body: {'username': usr.text, 'password': psw.text});
    var datauser = json.decode(response.body);
    if (datauser['error'] == true) {
      setState(() {
        msg = datauser['msg'];
      });
    } else {
      String emailAPI = datauser['email'];
      String fullnameAPI = datauser['fullname'];
      String id = datauser['id'];
      String photo = datauser['photo'];
      int level = int.parse(datauser['level']);
      setState(() {
        savePref(emailAPI, fullnameAPI, id, level, photo);
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeUser()));
    }
  }

  savePref(
      String email, String fullname, String id, int level, String photo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString('fullname', fullname);
      preferences.setString('email', email);
      preferences.setString('id', id);
      preferences.setInt('level', level);
      preferences.setString('photo', photo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        //width: double.infinity,
        //decoration: new BoxDecoration(
        //image: DecorationImage(
        //image: AssetImage('images/flutter/1.png'),
        //fit: BoxFit.cover,
        //)),
        child: new ListView(
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  new Image.asset(
                    'images/flutter/logologin.png',
                    width: 100,
                  ),
                  new Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          new TextField(
                            controller: usr,
                            decoration: InputDecoration(
                                hintText: 'Username',
                                labelText: 'Username',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          new TextField(
                            obscureText: true,
                            controller: psw,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          new RaisedButton(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  'LOGIN',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            color: Colors.lightBlue,
                            onPressed: () {
                              _login();
                            },
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          new Text(
                            msg,
                            style: new TextStyle(color: Colors.red),
                          )
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
