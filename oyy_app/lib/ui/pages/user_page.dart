import 'package:flutter/material.dart';
import 'order_all_page.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Map<String, dynamic>? userInfo;
  Map<String, dynamic> assets = {};
  Map<String, dynamic> service = {};

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    // 模拟用户
    userInfo = {
      'username': '黎吧啦',
      'email': 'libala@example.com',
      'avatar': 'assets/images/user.jpg', // 头像
    };

    // 模拟资产
    assets = {
      'balance': 1000000.0,
      'points': 500,
      'coupons': ['优惠券A', '优惠券B'],
    };
  }

  // 退单
  void deleteOrder(int index) {
    setState(() {
      OrderAllPage.orders.removeAt(index); // 移除订单
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('退单成功'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户页面'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 用户信息区域
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30.0,
                    child: Image.asset(
                      'lib/assets/images/user.jpg', // 用户头像
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '欢迎您，${userInfo!['username']}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        '邮箱：${userInfo!['email']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 资产
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '我的资产',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _AssetInfoCard(
                        title: '余额',
                        value: '${assets['balance']}',
                      ),
                      _AssetInfoCard(
                        title: '积分',
                        value: '${assets['points']}',
                      ),
                      _AssetInfoCard(
                        title: '优惠券',
                        value: '${assets['coupons'].length}张',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 订单
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '我的订单',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: OrderAllPage.orders.length,
                    itemBuilder: (context, index) {
                      final order = OrderAllPage.orders[index];
                      return OrderListItem(
                        order: order,
                        onDelete: () => deleteOrder(index),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 资产信息
class _AssetInfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _AssetInfoCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// 订单列表
class OrderListItem extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback onDelete;

  const OrderListItem({
    required this.order,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    double goodsPrice = order['goods_price'].toDouble();
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text('订单号: ${order['order_id']}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('商品名称: ${order['goods_name']}'),
            Text(
                '数量: ${order['quantity']}，总价: ￥${goodsPrice * order['quantity']}'),
          ],
        ),
        trailing: TextButton.icon(
          icon: Icon(Icons.delete),
          label: Text('退单'),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
