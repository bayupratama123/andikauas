import 'package:flutter/material.dart';
import './login.dart';
import './home_user.dart';
import './home_admin.dart';
import './akun.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        title: 'Login',
        home: new Login(),
        routes: <String, WidgetBuilder>{
          '/home_admin': (BuildContext context) => new HomeAdmin(),
          '/home_user': (BuildContext context) => new HomeUser(),
          '/login': (BuildContext context) => new Login(),
          '/akun': (BuildContext context) => new Akun(),
        });
  }
}
