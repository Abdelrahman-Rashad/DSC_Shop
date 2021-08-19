import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shop/classes/cloudDatabase.dart';
import 'package:shop/classes/theme_provider.dart';
import 'package:shop/pages/profile.dart';
import 'package:provider/provider.dart';

class shop_Drawer extends StatefulWidget {
  shop_Drawer({Key? key, required this.email}) : super(key: key);

  String email;
  @override
  _shop_DrawerState createState() => _shop_DrawerState();
}

class _shop_DrawerState extends State<shop_Drawer> {
  List users = [];
  late String _name = "", _userEmail = "";
  late CloudDatabase db;

  checkUser() {
    db = CloudDatabase();
    db.initialize();
    db.read().then((value) => {
          setState(() {
            users = value;
            for (int i = 0; i < users.length; i++) {
              if (users[i]['email'] == widget.email) {
                _name = users[i]['name'];
                _userEmail = users[i]['email'];
              }
            }
          })
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<Themeprovider>(context);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Profile(
                          db: db,
                          name: _name,
                          email: _userEmail,
                        )));
              },
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/account.png'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft + Alignment(0.6, 1.1),
                    child: IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: () {},
                      color: Colors.white,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight + Alignment(0, 0.3),
                    child: Text(
                      _userEmail,
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Mode",
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
            leading: Switch(
              value: themeprovider.isDarkMode,
              onChanged: (value) {
                final provider =
                    Provider.of<Themeprovider>(context, listen: false);
                provider.toggleTheme(value);
              },
              activeTrackColor: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
