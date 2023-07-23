import 'package:flutter/material.dart';

class BottomNavBarItemsProvider {
  static final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.airplay_sharp),
      label: 'Витрина',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search_rounded),
      label: 'Каталог',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.cases_rounded),
      label: 'Корзина',
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.delivery_dining_rounded), label: "Заказы"),
  ];
}
