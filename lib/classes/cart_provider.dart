import 'package:flutter/material.dart';
import 'package:shop/classes/shopAPI.dart';

class CartModel extends ChangeNotifier {
  final List<Item> itemscart = [];
  final List<Item> itemsfavorite = [];
  int totalcost = 0;

  void totalprice(double cost) {
    totalcost += cost.toInt();
    notifyListeners();
  }

  int getprice() => totalcost;

  void addcart(Item item) {
    itemscart.add(item);
    notifyListeners();
  }

  void addfavorite(Item item) {
    itemsfavorite.add(item);
    notifyListeners();
  }

  void deletefavorite(int index) {
    itemsfavorite.removeAt(index);
    notifyListeners();
  }

  void deletecart(int index, double cost) {
    itemscart.removeAt(index);
    totalcost -= cost.toInt();
    notifyListeners();
  }
}
