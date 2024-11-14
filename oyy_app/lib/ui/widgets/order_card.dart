import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String goodsName;
  final double goodsPrice;
  final int quantity;
  final DateTime orderTime;
  final String productImage;
  final VoidCallback onDelete;

  OrderCard({
    required this.orderId,
    required this.goodsName,
    required this.goodsPrice,
    required this.quantity,
    required this.orderTime,
    required this.productImage,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(productImage),
        title: Text('订单号: $orderId'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('商品名称: $goodsName'),
            Text('商品价格: ￥$goodsPrice'),
            Text('数量: $quantity'),
            Text('订单时间: ${orderTime.toLocal()}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
