import 'package:flutter/material.dart';
import 'package:shop/classes/cart_provider.dart';
import 'package:shop/classes/shopAPI.dart';
import 'package:provider/provider.dart';

class CardStyle extends StatefulWidget {
  CardStyle({Key? key, required this.items, required this.index})
      : super(key: key);

  List<Item> items;
  int index;
  @override
  _CardStyleState createState() => _CardStyleState();
}

class _CardStyleState extends State<CardStyle> {
  @override
  bool favorite_item = false;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 10,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(
                  widget.items[widget.index].image,
                  height: 150,
                  width: 100,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.items[widget.index].title,
                          style: TextStyle(fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "\$${widget.items[widget.index].price.toString()}",
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 10),
                      child: Text(widget.items[widget.index].category,
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20)),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      favorite_item ? Icons.favorite : Icons.favorite_border,
                      color: favorite_item ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        favorite_item = !favorite_item;
                      });
                      Provider.of<CartModel>(context, listen: false)
                          .addfavorite(widget.items[widget.index]);
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false)
                            .addcart(widget.items[widget.index]);
                        Provider.of<CartModel>(context, listen: false)
                            .totalprice(widget.items[widget.index].price);
                      },
                      icon: Icon(Icons.add_shopping_cart))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
