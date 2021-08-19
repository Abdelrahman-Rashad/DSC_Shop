import 'package:flutter/material.dart';
import 'package:shop/classes/cart_provider.dart';
import 'package:shop/classes/shopAPI.dart';
import 'package:provider/provider.dart';

class CartCard extends StatefulWidget {
  CartCard({Key? key, required this.index, required this.items})
      : super(key: key);

  List<Item> items;
  int index;
  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
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
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        Provider.of<CartModel>(context, listen: false)
                            .deletecart(
                                widget.index, widget.items[widget.index].price);
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
