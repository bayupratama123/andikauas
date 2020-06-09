import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_mobile/home_admin.dart';
import './login.dart';
import './akun.dart';

class HomeUser extends StatefulWidget {
  @override
  _HomeUserState createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  String id, nama, email, photo, fullname;
  int level = 0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      level = preferences.getInt('level');
      id = preferences.getString('id');
      fullname = preferences.getString('fullname');
      email = preferences.getString('email');
      photo = preferences.getString('photo');
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt('level', 0);
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (level) {
      case 1:
        return HomeAdmin();
        break;
      case 2:
        return Scaffold(
          appBar: AppBar(
            title: Text('Home User'),
          ),
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text(fullname),
                  accountEmail: new Text(email),
                  currentAccountPicture: new GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => Akun(),
                      ));
                    },
                    child: new CircleAvatar(
                      backgroundImage: AssetImage('images/flutter/profile.jpg'),
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/flutter/1.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                new ListTile(
                  title: new Text('Logout'),
                  trailing: new Icon(Icons.settings),
                  onTap: () {
                    signOut();
                  },
                ),
              ],
            ),
          ),
          /////////////////////////////////////////////////////////////////////////
          ////////////////////////////////////////////////////////////////
          body: new Column(
            children: <Widget>[
              Image.asset("images/flutter/3.jpg"),
              //Setiap bagian pada body dipisahkan container
              Container(
                color: Colors.lightBlue,
                padding: const EdgeInsets.all(10),
                //untuk Membuat tampilan secara horizontal maka digunakan row
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'IPA RANGKUM',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),

              //Setiap bagian pada body dipisahkan Container
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Theme.of(context).dividerColor)),
                ),
                //Untuk membuat tampilan secara horizontal maka digunakan row
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //untuk membuat tampilan secara vertikal maka digunakan column
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.contacts, color: Colors.grey[800]),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Contact",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.info, color: Colors.grey[800]),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            "About",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.share, color: Colors.grey[800]),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Share",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Materi ringkas Ilmu Pengetahuan Alam                     '
                  'Sekolah Menengah Pertama/Madrasah Sanawiah               '
                  'Kelas 7, 8, dan 9                                                                    '
                  'Biologi - Fisika - Kimia',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      default:
        return Login();
    }
  }
}
