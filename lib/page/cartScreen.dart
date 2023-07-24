import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade/models/cartModel.dart';
import 'package:trade/page/makeOrderScreen.dart';
import 'package:trade/service/apiService.dart';

import 'BottomNavBarItemsProvider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartResponse? _cartData;
  bool _isLoading = false;
  final int _currentIndex = 2;

  final ApiService _apiService = ApiService(Dio());

  @override
  void initState() {
    super.initState();
    _fetchCartData();
  }

  Future<void> _fetchCartData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _cartData = await _apiService.calculateCart();
      setState(() {
        _cartData = _cartData;
      });
    } catch (error) {
      print("Ошибка при выполнении запроса: $error");
      setState(() {
        _cartData = null;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addToCart(ProductItem productItem) {
    setState(() {
      productItem.count++;
    });
  }

  void _removeFromCart(ProductItem productItem) {
    setState(() {
      if (productItem.count > 0) {
        productItem.count--;
      }
    });
  }

  void _updateCartData(ProductItem productItem) async {
    if (productItem.count == 0) {
      try {
        Map<String, dynamic> requestBody = {
          "product_id": productItem.product.id,
        };
        _cartData = await _apiService.deleteCartData(requestBody);
        setState(() {
          _cartData = _cartData;
        });
      } catch (error) {
        print("Ошибка при выполнении DELETE-запроса: $error");
      }
    } else {
      try {
        Map<String, dynamic> requestBody = {
          "product_id": productItem.product.id,
          "count": productItem.count,
        };
        _cartData = await _apiService.putCartData(requestBody);
        setState(() {
          _cartData = _cartData;
        });
      } catch (error) {
        print("Ошибка при выполнении PUT-запроса: $error");
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
          'Корзина',
          style: TextStyle(fontSize: 21, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (_cartData == null || _cartData!.products.isEmpty)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 32),
                        child: Text(
                          'В вашей корзине пока ничего нет',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 350,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: const Text("Перейти к покупкам")),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _cartData!.products.length,
                  itemBuilder: (context, index) {
                    ProductItem? productItem = _cartData!.products[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: productItem.product.picture,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(
                          productItem.product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Цена: ${productItem.product.price.split(".")[0]} ₽ '),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _addToCart(productItem);
                                _updateCartData(productItem);
                              },
                              icon: Icon(Icons.add),
                            ),
                            Text("${productItem.count}"),
                            IconButton(
                              onPressed: () {
                                _removeFromCart(productItem);
                                _updateCartData(productItem);
                              },
                              icon: Icon(Icons.remove),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Обработчик нажатий на элементы нижней панели
          if (index == 0) {
          } else if (index == 1) {
            Navigator.pushNamed(context, '/catalog');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/cart');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/orders');
          }
        },
        items: BottomNavBarItemsProvider.items,
      ),
      bottomSheet: (_cartData == null || _cartData!.products.isEmpty)
          ? null
          : BottomAppBar(
              child: Container(
                height: 142,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 6),
                      child: Text(
                        "Итого: ${_cartData?.price.split(".")[0]} ₽",
                        style: const TextStyle(fontSize: 21),
                      ),
                    ),
                    Text(
                      'Цена без скидки: ${_cartData?.oldPrice?.split(".")[0] ?? "Cкидка отсуствутет"}${_cartData?.oldPrice != null ? " ₽" : ""}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        width: 360,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MakeOrderScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: const Text("Перейти к оформлению заказа")),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
