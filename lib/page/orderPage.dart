import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:trade/models/orderListModel.dart';
import 'package:trade/service/apiService.dart';

import 'BottomNavBarItemsProvider.dart';
import 'orderDetailsScreen.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final int _currentIndex = 3;
  List<Order> _orders = [];
  bool _isLoading = false;
  final ApiService _orderService = ApiService(Dio());

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _orders = await _orderService.orderData();
    } catch (error) {
      print("Ошибка при загрузке заказов: $error");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  String formatDateTime(String dateTimeString) {
    final parsedDateTime = DateTime.parse(dateTimeString);
    final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDateTime);
    final formattedTime = DateFormat('HH:mm:ss').format(parsedDateTime);
    return "$formattedDate $formattedTime";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Список заказов',
          style: TextStyle(fontSize: 21, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _orders.isEmpty
              ? const Center(
                  child: Text('Список заказов пуст'),
                )
              : ListView.builder(
                  itemCount: _orders.length,
                  itemBuilder: (context, index) {
                    Order order = _orders[index];
                    final formattedDate = formatDateTime(order.createdAt);
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            order.items.isNotEmpty
                                ? order.items[0].picture
                                : '',
                          ),
                        ),
                        title: Text('Заказ №${order.id}'),
                        subtitle: Text('Дата создания: $formattedDate'),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrderDetailsScreen(order: order),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
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
            Navigator.pushReplacementNamed(context, '/orders');
          }
        },
        items: BottomNavBarItemsProvider.items,
      ),
    );
  }
}
