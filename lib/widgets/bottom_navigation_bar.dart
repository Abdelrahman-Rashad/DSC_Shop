import 'package:flutter/material.dart';
import 'package:shop/pages/cart_screen.dart';
import 'package:shop/pages/favorite_screen.dart';
import 'package:shop/pages/home.dart';

class BottomNavigtion extends StatefulWidget {
  BottomNavigtion({Key? key, required this.Email}) : super(key: key);
  String Email;
  @override
  _BottomNavigtionState createState() => _BottomNavigtionState();
}

class _BottomNavigtionState extends State<BottomNavigtion> {
  int SelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> taps = [
      Home(email: widget.Email),
      Favorite(),
      CartScreen()
    ];
    return Scaffold(
      body: taps[SelectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        child: BottomNavigationBar(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.white,
          iconSize: 30.0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
          ],
          onTap: (index) {
            setState(() {
              SelectedIndex = index;
            });
          },
          currentIndex: SelectedIndex,
        ),
      ),
    );
  }
}
