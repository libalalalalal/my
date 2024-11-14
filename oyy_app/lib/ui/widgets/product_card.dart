// product_card.dart

import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            product.imageUrl,
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            product.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            '￥${product.price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
          SizedBox(height: 10),
          Text(
            '库存: ${product.stock}',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
