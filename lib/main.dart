import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/classes/cart_provider.dart';
import 'package:shop/splash%20screen/splash.dart';

import 'classes/theme_provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<Themeprovider>(
              create: (context) => Themeprovider()),
          ChangeNotifierProvider<CartModel>(create: (context) => CartModel())
        ],
        builder: (context, _) {
          final provider = Provider.of<Themeprovider>(context);
          return MaterialApp(
            home: Splash(),
            debugShowCheckedModeBanner: false,
            theme: MyThemes.lightTheme,
            themeMode: provider.themeMode,
            darkTheme: MyThemes.darkTheme,
          );
        },
      );
}
