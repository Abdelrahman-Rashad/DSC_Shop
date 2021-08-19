import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/classes/cart_provider.dart';
import 'package:shop/classes/shopAPI.dart';
import 'package:shop/widgets/card_style.dart';
import 'package:shop/widgets/cart_card.dart';
import 'package:shop/widgets/favoirte_card.dart';

import 'item_detail.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of<CartModel>(context).itemscart;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          title: Text(
            "Cart",
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
                child: Column(
                  children: [
                    CartCard(items: items, index: index),
                  ],
                ));
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(
            "Total Cost : ${Provider.of<CartModel>(context).totalcost}",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
        ));
  }
}
