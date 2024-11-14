import 'package:flutter/material.dart';
import 'package:OYY_APP/ui/widgets/order_card.dart';

class OrderAllPage extends StatelessWidget {
  static List<Map<String, dynamic>> orders = []; // 全局的订单数据
  static int nextOrderId = 1;

  static void addOrder(Map<String, dynamic> newOrder) {
    String orderId = nextOrderId.toString();
    nextOrderId++;
    DateTime orderTime = DateTime.now();

    newOrder['order_id'] = orderId;
    newOrder['order_time'] = orderTime.toIso8601String();
    orders.add(Map<String, dynamic>.from(newOrder));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('全部订单'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          double goodsPrice = order['goods_price'].toDouble();

          return OrderCard(
            orderId: order['order_id'],
            goodsName: order['goods_name'],
            goodsPrice: goodsPrice,
            quantity: order['quantity'],
            orderTime: DateTime.parse(order['order_time']),
            // 显示商品图片在 OrderCard 中
            productImage: order['pics'][0]['pics_big'],
            onDelete: () {
              orders.removeAt(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('订单 ${order['order_id']} 已退单'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
