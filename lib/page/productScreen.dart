import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade/models/productModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trade/page/orderPage.dart';
import 'package:trade/page/productDetailsScreen.dart';
import 'package:trade/page/cartScreen.dart';

import '../models/sortingOptionModel.dart';
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
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int _currentIndex = 1;
  ApiService? _apiService;
  List<Product> _products = [];
  List<SortingOption> _sortingOptions = [];
  bool _isLoading = true;
  String? _selectedSortingOption;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService(Dio());
    _fetchSortingOptions();
  }

  Future<void> _fetchSortingOptions() async {
    try {
      List<SortingOption> sortingOptions = await _apiService!.sortData();
      setState(() {
        _sortingOptions = sortingOptions;
        _selectedSortingOption = sortingOptions.isNotEmpty ? sortingOptions[0].id : null;
        _fetchProductData();
      });
    } catch (e) {
      print("Error sort data: $e");
    }
  }

  Future<void> _fetchProductData() async {
    try {
      if (_selectedSortingOption == null) {
        return;
      }

      Map<String, dynamic> requestBody = {
        "sort_by": _selectedSortingOption,
      };

      ApiResponse response = await _apiService!.postProductData(requestBody);
      setState(() {
        _products = response.results;
        _isLoading = false;
      });
    } catch (e) {
      // Обработка ошибок
      setState(() {
        _isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Список товаров',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _selectedSortingOption = value;
                _isLoading = true;
                _fetchProductData();
              });
            },
            itemBuilder: (context) {
              return _sortingOptions.map((option) {
                return PopupMenuItem<String>(
                  value: option.id,
                  child: Text(option.name),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) => ProductCard(product: _products[index]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {} else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/catalog');
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






