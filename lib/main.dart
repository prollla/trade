import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:trade/models/productModel.dart'; // Импортируйте вашу модель данных
import 'package:trade/service/apiService.dart';
import 'package:trade/page/productScreen.dart'; // Импортируйте ваш ApiService

void main() async {
  // Создайте экземпляр Dio для использования в ApiService
  final dio = Dio();

  // Создайте экземпляр ApiService с базовым URL
  final apiService = ApiService(dio);

  try {
    final ApiResponse response = await apiService.postProductData();

    runApp(MyApp(products: response.results));
  } catch (e) {
    print("Error fetching data: $e");
  }
}

class MyApp extends StatelessWidget {
  final List<Product> products;

  MyApp({required this.products});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black
        )
      ),
      home: ProductsScreen(products: products),
    );
  }
}

