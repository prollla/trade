import 'package:flutter/material.dart';// Импортируйте вашу модель данных
import 'package:trade/page/cartScreen.dart';
import 'package:trade/page/orderPage.dart';
import 'package:trade/page/productScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/catalog',
      routes: {
        '/catalog': (context) => ProductsScreen(),
        '/cart': (context) => CartScreen(),
        '/orders': (context) => OrderScreen(),
      },
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
        ),
      ),
    );
  }
}

