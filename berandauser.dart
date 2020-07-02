import 'package:uas/ui/berandaadmin.dart';
import 'package:uas/ui/login.dart';
import 'package:uas/ui/beranda.dart' as beranda;
import 'package:uas/ui/produklist.dart' as listproduk;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Berandauser extends StatefulWidget {
  @override
  _BerandauserState createState() => _BerandauserState();
}

class _BerandauserState extends State<Berandauser> with SingleTickerProviderStateMixin {
  TabController controller;
  String id, nama, email, photo;
  int level = 0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      level = preferences.getInt("level");
      id = preferences.getString("id");
      nama = preferences.getString("nama");
      email = preferences.getString("email");
      photo = preferences.getString("photo");
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("level", 0);
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  @override
  void initState() {
    // TODO: implement initState
    controller = new TabController(vsync: this, length: 2);
    super.initState();
    getPref();
  }

  //jangan lupa tambahkan dispose untuk berpindah halaman
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (level) {
      case 1:
        return Berandaadmin();
        break;
      case 2:
        return Scaffold(
            appBar: AppBar(
              title: Text("Beranda User"),
            ),
            body: new TabBarView(
              //terdapat controller untuk mengatur halaman
              controller: controller,
              children: <Widget>[
                //pemanggilan halaman dimulai dari alias.className halaman yang diload
                new beranda.Beranda(),
                new listproduk.ProdukList(),
              ],
            ),
            //membuat bottom tab
            bottomNavigationBar: new Material(
              color: Colors.blue,
              child: new TabBar(
                controller: controller,
                tabs: <Widget>[
                  //menggunakan icon untuk mempercantik nama tab
                  //icon berurutan sesuai pemanggilan halaman
                  new Tab(icon: new Icon(Icons.home)),
                  new Tab(icon: new Icon(Icons.list))
                ],
              ),
            ));
        break;
      default:
        return Login();
    }
  }
}
