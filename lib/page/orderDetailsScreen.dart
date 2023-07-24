import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/orderListModel.dart';
import 'BottomNavBarItemsProvider.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;
  final int _currentIndex = 3;

  OrderDetailsScreen({required this.order});

  String formatDateTime(String dateTimeString) {
    final parsedDateTime = DateTime.parse(dateTimeString);
    final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDateTime);
    final formattedTime = DateFormat('HH:mm:ss').format(parsedDateTime);
    return "$formattedDate $formattedTime";
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = formatDateTime(order.createdAt);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Детали заказа',
          style: TextStyle(fontSize: 21, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Имя пользователя: ${order.userName}'),
            const SizedBox(height: 8),
            Text('Телефон пользователя: ${order.userPhone}'),
            const SizedBox(height: 8),
            Text('Дата создания заказа: $formattedDate'),
            const SizedBox(height: 8),
            Text('Сумма заказа: ${order.fullPrice}'),
            const SizedBox(height: 8),
            Text(
                'Статус заказа: ${order.status == 0 ? 'В ожидании' : 'Выполнен'}'),
            const SizedBox(height: 8),
            const Text('Товары в заказе:'),
            const SizedBox(height: 8),
            ...order.items.map(
                (item) => Text('- ${item.name}, Количество: ${item.count}')),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
          } else if (index == 1) {
            Navigator.pushNamed(context, '/catalog');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/cart');
          } else if (index == 3) {
            Navigator.pop(context, '/orders');
          }
        },
        items: BottomNavBarItemsProvider.items,
      ),
    );
  }
}
