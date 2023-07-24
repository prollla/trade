import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade/page/orderPage.dart';
import 'package:trade/service/apiService.dart';

import '../models/deliveryModel.dart';
import '../models/orderListModel.dart';
import '../models/paymentMethod.dart';
import 'BottomNavBarItemsProvider.dart';

class MakeOrderScreen extends StatefulWidget {
  @override
  _MakeOrderScreenState createState() => _MakeOrderScreenState();
}

class _MakeOrderScreenState extends State<MakeOrderScreen> {
  final ApiService apiService = ApiService(Dio());
  final _currentIndex = 3;
  List<Delivery> deliveries = [];
  Delivery? selectedDelivery;
  List<PaymentMethod> paymentMethods = [];
  PaymentMethod? selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _fetchDeliveries();
  }

  Future<void> _fetchDeliveries() async {
    try {
      List<Delivery> deliveryResponse = await apiService.deliveryData();
      List<PaymentMethod> paymentResponse = await apiService.paymentData();
      setState(() {
        deliveries = deliveryResponse;
        paymentMethods = paymentResponse;
      });
    } catch (e) {
      // Обработка ошибок
    }
  }

  Future<void> _makeOrder() async {
    Map<String, dynamic> requestBody = {
      "user_name": "Anton",
      "user_phone": "89202802099",
      "delivery_id": selectedDelivery!.id,
      "delivery_type": selectedDelivery!.type,
      "payment_id": selectedPaymentMethod!.id,
      "payment_type": selectedPaymentMethod!.type,
    };

    try {
      // Выполните запрос оформления заказа
      await apiService.makeOrder(requestBody);
      // Нет необходимости объявлять и использовать переменную order
    } on DioException catch (e) {
      // Обработка ошибок
      if (e.response != null) {
        // Проверяем, есть ли в ответе поле error_text
        if (e.response!.data.containsKey('error_text')) {
          String errorText = e.response!.data['error_text'];
          // Отображаем SnackBar с текстом ошибки
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorText)),
          );
        } else {
          print("Ошибка при оформлении заказа: ${e.message}");
        }
      } else {
        print("Неизвестная ошибка: $e");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Оформление заказа',
          style: TextStyle(fontSize: 21, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Выберите способ доставки:'),
          Wrap(
            spacing: 8.0,
            children: deliveries.map((delivery) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDelivery = delivery;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: delivery == selectedDelivery
                          ? Colors.blue
                          : Colors.transparent,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        delivery.icon,
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(height: 8.0),
                      Text(delivery.title),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(
              height: 16.0), // Разделитель между способами доставки и оплаты
          Text('Выберите способ оплаты:'),
          Wrap(
            spacing: 8.0,
            children: paymentMethods.map((payment) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = payment;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: payment == selectedPaymentMethod
                          ? Colors.blue
                          : Colors.transparent,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        payment.icon,
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(height: 8.0),
                      Text(payment.title),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 360,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            // Здесь обработайте нажатие кнопки "Оформить заказ" с выбранными доставкой и оплатой
            if (selectedDelivery != null && selectedPaymentMethod != null) {
              _makeOrder();
              Navigator.pushNamed(context, '/orders');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
          child: Text('Оформить заказ'),
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
            Navigator.pushNamed(context, '/orders');
          }
        },
        items: BottomNavBarItemsProvider.items,
      ),
    );
  }
}
