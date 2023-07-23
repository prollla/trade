import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade/models/productModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trade/page/orderPage.dart';
import 'package:trade/page/productDetailsScreen.dart';
import 'package:trade/page/cartScreen.dart';

import '../service/apiService.dart';
import 'BottomNavBarItemsProvider.dart';// Импортируйте вашу модель данных

class ProductCard extends StatelessWidget {
  final Product product;
  final ApiService _apiService = ApiService(Dio());

  ProductCard({super.key, required this.product});


  Future<void> _addToCart() async {
    try {
      Map<String, dynamic> requestBody = {
        "product_id": product.id,
      };
      await _apiService.postCartData(requestBody);
    } catch (error) {
      print("Ошибка при выполнении POST-запроса: $error");
      // Обработка ошибки
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        width: 164,
        height: 250,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 164,
                height: 164,
                child: Padding(
                  padding: const EdgeInsets.only(top: 7, bottom: 3),
                  child: CachedNetworkImage(
                    imageUrl: "${product.picture}",
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Text('${product.name}', style: const TextStyle(fontSize: 12)),
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 11),
                      child: Text('${product.price?.split(".")[0]} ₽',
                          style: const TextStyle(fontSize: 14)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 66),
                      child: IconButton(
                          onPressed: () {
                            _addToCart();
                          },
                          icon: const Icon(Icons.shopping_basket)),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductsScreen extends StatefulWidget {
  final List<Product> products;

  ProductsScreen({required this.products});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Список товаров',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
        ),
        itemCount: widget.products.length,
        itemBuilder: (context, index) =>
            ProductCard(product: widget.products[index]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Обработчик нажатий на элементы нижней панели
          if (index == 0) {

          } else if (index == 1) {
            //
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            );
          } else if( index == 3){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderScreen(),
              ),
            );
          }
        },
        items: BottomNavBarItemsProvider.items,
      ),
    );
  }
}
