import 'package:flutter/material.dart';
import 'order_all_page.dart';

class OrderConfirmationPage extends StatelessWidget {
  final Map<String, dynamic> orderDetails;

  OrderConfirmationPage({required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('确认订单'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '订单详情',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Image.network(
                orderDetails['pics'][0]['pics_big'], // 显示第一个商品图片
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '商品名称: ${orderDetails['goods_name']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '商品价格: ￥${orderDetails['goods_price']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '数量: ${orderDetails['quantity']}',
              style: TextStyle(fontSize: 18),
            ),
            Spacer(), // 占位符
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitOrder(context);
                  },
                  child: Text('确认订单'),
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // 返回上一页
                  },
                  child: Text('取消订单'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitOrder(BuildContext context) {
    // 添加订单
    OrderAllPage.addOrder(orderDetails);

    // 假设已经成功提交订单，跳转到订单列表页
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderAllPage(),
      ),
    );
  }
}
