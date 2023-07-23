import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:trade/models/orderListModel.dart'; // Замените на путь к вашим моделям данных
import 'package:trade/service/apiService.dart'; // Замените на путь к вашему сервису Retrofit

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> _orders = [];
  bool _isLoading = false;
  final ApiService _orderService =
      ApiService(Dio()); // Замените на ваш сервис Retrofit

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список заказов'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _orders.isEmpty
              ? Center(
                  child: Text('Список заказов пуст'),
                )
              : ListView.builder(
                  itemCount: _orders.length,
                  itemBuilder: (context, index) {
                    Order order = _orders[index];
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
                        subtitle: Text('Дата создания: ${order.createdAt}'),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            // При нажатии на заказ, перейти на экран с деталями заказа
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
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали заказа №${order.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Имя пользователя: ${order.userName}'),
            SizedBox(height: 8),
            Text('Телефон пользователя: ${order.userPhone}'),
            SizedBox(height: 8),
            Text('Дата создания заказа: ${order.createdAt}'),
            SizedBox(height: 8),
            Text('Сумма заказа: ${order.fullPrice}'),
            SizedBox(height: 8),
            Text(
                'Статус заказа: ${order.status == 0 ? 'В ожидании' : 'Выполнен'}'),
            SizedBox(height: 8),
            Text('Товары в заказе:'),
            SizedBox(height: 8),
            ...order.items.map(
                (item) => Text('- ${item.name}, Количество: ${item.count}')),
          ],
        ),
      ),
    );
  }
}
