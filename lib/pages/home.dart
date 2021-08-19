import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shop/classes/cloudDatabase.dart';
import 'package:shop/classes/shopAPI.dart';
import 'package:shop/pages/item_detail.dart';
import 'package:shop/widgets/card_style.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key? key, required this.email}) : super(key: key);

  String email;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = new TextEditingController();
  List<Item> _FilteredList = [];
  List<Item> items = [];
  String filter = '';
  Icon actionIcon = Icon(Icons.search);
  Widget appbartitle = new Text(
    "DSC Shop",
    style: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
        fontFamily: 'Ubuntu'),
  );

  Future<Null> getdata() async {
    String url = "https://fakestoreapi.com/products";
    final jsonData = await http.get(Uri.parse(url));
    if (jsonData.statusCode == 200) {
      final data = json.decode(jsonData.body);
      setState(() {
        for (Map user in data) {
          items.add(Item.fromjson(user));
        }
      });

      controller.addListener(() {
        if (controller.text.isEmpty) {
          setState(() {
            filter = controller.text;
          });
        }
      });
    } else {
      throw Exception("error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    print(items);
  }

  onsearchtextchanged(String text) async {
    _FilteredList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    items.forEach((element) {
      if (element.title.contains(text)) _FilteredList.add(element);
    });
    setState(() {});
  }

  Widget _buildItemsList() {
    if (items.isNotEmpty) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ItemDetail(
                          items: items,
                          index: index,
                        )));
              },
              child: CardStyle(items: items, index: index));
        },
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSearchResults() {
    if (_FilteredList.isNotEmpty) {
      return ListView.builder(
        itemCount: _FilteredList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ItemDetail(
                          items: _FilteredList,
                          index: index,
                        )));
              },
              child: CardStyle(items: _FilteredList, index: index));
        },
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildBody() {
    return _FilteredList.length != 0 || controller.text.isNotEmpty
        ? _buildSearchResults()
        : _buildItemsList();
  }

  @override
  Widget build(BuildContext context) {
    final text = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? 'DarkTheme'
        : 'LightTheme';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: appbartitle,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    actionIcon = Icon(Icons.close);
                    appbartitle = TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.black)),
                      onChanged: onsearchtextchanged,
                      style: TextStyle(color: Colors.blue),
                      autofocus: true,
                      cursorColor: Colors.blue,
                    );
                  } else {
                    actionIcon = Icon(Icons.search);
                    appbartitle = Text("DSC Shop",
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontFamily: 'Ubuntu'));
                    controller.clear();
                    onsearchtextchanged("");
                  }
                });
              },
              icon: actionIcon)
        ],
      ),
      body: _buildBody(),
      drawer: shop_Drawer(
        email: widget.email,
      ),
    );
  }
}
