import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/productModel.dart';
import 'BottomNavBarItemsProvider.dart';
import 'cartScreen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title:Text(
          '${product.name}',
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 296,
              width: 273,
              child: CachedNetworkImage(
                imageUrl: "${product.picture}",
                placeholder: (context, url) =>
                const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child:
              Text('${product.name}', style: const TextStyle(fontSize: 20)),
            ),
            Text(
              '${product.price?.split(".")[0]} ₽',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              '${product.oldPrice?.split(".")[0] ?? ""}${product.oldPrice != null ? " ₽" : ""}',
              style: const TextStyle(fontSize: 18, decoration: TextDecoration.lineThrough),
            ),
            Text('Бренд: ${product.brand}', style: TextStyle(fontSize: 24),)

            // Добавьте другие поля о товаре по аналогии
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Здесь вы можете установить индекс активного элемента нижней панели
        onTap: (index) {
          // Обработчик нажатий на элементы нижней панели
          if (index == 0) {

          } else if (index == 1) {
            Navigator.pop(context, '/catalog');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/cart');
          } else if( index == 3){
            Navigator.pushNamed(context, '/orders');
          }
        },
        items: BottomNavBarItemsProvider.items,
      ),
    );
  }
}