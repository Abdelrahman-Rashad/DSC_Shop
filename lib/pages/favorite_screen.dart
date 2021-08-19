import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/classes/cart_provider.dart';
import 'package:shop/classes/shopAPI.dart';
import 'package:shop/widgets/card_style.dart';
import 'package:shop/widgets/favoirte_card.dart';

import 'item_detail.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of<CartModel>(context).itemsfavorite;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          "Favorite",
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
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
              child: FavoirteCard(items: items, index: index));
        },
      ),
    );
  }
}
