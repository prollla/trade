import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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

class _MakeOrderScreenState extends State<MakeOrderScreen> with WidgetsBindingObserver {
  final ApiService apiService = ApiService(Dio());
  final _currentIndex = 3;
  List<Delivery> deliveries = [];
  Delivery? selectedDelivery;
  List<PaymentMethod> paymentMethods = [];
  PaymentMethod? selectedPaymentMethod;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool isKeyboardVisible = false;


  @override
  void initState() {
    super.initState();
    _fetchDeliveries();
    WidgetsBinding.instance?.addObserver(this);
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });
  }
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  Future<void> _fetchDeliveries() async {
    try {
      List<Delivery> deliveryResponse = await apiService.deliveryData();
      List<PaymentMethod> paymentResponse = await apiService.paymentData();
      setState(() {
        deliveries = deliveryResponse;
        paymentMethods = paymentResponse;
      });
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

  Future<void> _makeOrder() async {
    Map<String, dynamic> requestBody = {
      "user_name": _nameController.text,
      "user_phone": _nameController.text,
      "delivery_id": selectedDelivery!.id,
      "delivery_type": selectedDelivery!.type,
      "payment_id": selectedPaymentMethod!.id,
      "payment_type": selectedPaymentMethod!.type,
    };

    try {
      await apiService.makeOrder(requestBody);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.data.containsKey('error_text')) {
          String errorText = e.response!.data['error_text'];
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
          const Text('Введите имя:'),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Введите ваше имя',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text('Введите номер телефона:'),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Введите номер телефона',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text('Выберите способ доставки:'),
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
                  padding: const EdgeInsets.all(8.0),
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
                      CachedNetworkImage(
                        imageUrl: delivery.icon,
                        height: 80,
                        width: 80,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(height: 8.0),
                      Text(delivery.title),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(
              height: 16.0), // Разделитель между способами доставки и оплаты
          const Text('Выберите способ оплаты:'),
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
                      CachedNetworkImage(
                        imageUrl: payment.icon,
                        width: 80,
                        height: 80,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(height: 8.0),
                      Text(payment.title),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      floatingActionButton: !isKeyboardVisible ? SizedBox(
        width: 360,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (selectedDelivery != null && selectedPaymentMethod != null &&
                _nameController.text.isNotEmpty &&
                _phoneController.text.isNotEmpty) {
              _makeOrder();
              Navigator.pushReplacementNamed(context, '/orders');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
          child: const Text('Оформить заказ'),
        ),
      )
      :null,
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
