import 'package:flutter/material.dart';
import 'order_confirmation_page.dart';
import 'order_all_page.dart';

class ShoppingCartPage extends StatefulWidget {
  static List<Map<String, dynamic>> cartItems = [];

  static void addToCart(Map<String, dynamic> goodsDetail) {
    goodsDetail['quantity'] = 1; // 默认数量为1
    cartItems.add(goodsDetail);
  }

  static void placeOrder(BuildContext context) {
    if (cartItems.isNotEmpty) {
      // 处理订单
      for (var item in cartItems) {
        OrderAllPage.addOrder(item);
      }

      // 清空购物车
      cartItems.clear();

      // 跳转到订单页面或其他页面，并移除之前的页面堆栈
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => OrderAllPage(),
        ),
        (route) => route.isFirst, // 移除所有旧页面，直到返回到首页
      );
    }
  }

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  void navigateToOrderConfirmation(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderConfirmationPage(orderDetails: item),
      ),
    );
  }

  void _increaseQuantity(int index) {
    setState(() {
      ShoppingCartPage.cartItems[index]['quantity']++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (ShoppingCartPage.cartItems[index]['quantity'] > 1) {
        ShoppingCartPage.cartItems[index]['quantity']--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: ListView.builder(
        itemCount: ShoppingCartPage.cartItems.length,
        itemBuilder: (context, index) {
          final item = ShoppingCartPage.cartItems[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(item['pics'][0]['pics_big']),
              title: Text(item['goods_name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('￥${item['goods_price']}'),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => _decreaseQuantity(index),
                      ),
                      Text('数量: ${item['quantity']}'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => _increaseQuantity(index),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        ShoppingCartPage.cartItems.removeAt(index);
                      });
                    },
                    child: Column(
                      children: [
                        Icon(Icons.delete),
                        Text(
                          '删除',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      navigateToOrderConfirmation(item);
                    },
                    child: Column(
                      children: [
                        Icon(Icons.shopping_bag),
                        Text(
                          '购买',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 56.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              ShoppingCartPage.placeOrder(context);
            },
            child: Text('全部下单'),
          ),
        ),
      ),
    );
  }
}
