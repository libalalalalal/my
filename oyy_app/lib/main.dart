import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:OYY_APP/ui/pages/home_page.dart'; // 主页
import 'package:OYY_APP/ui/pages/user_page.dart'; // 用户
import 'package:OYY_APP/ui/pages/category_page.dart'; // 商品分类
import 'package:OYY_APP/ui/pages/shopping_cart_page.dart'; // 购物车

// 全局变量
int nextOrderId = 1;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 禁止横屏显示
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(), // 主页页面
    CategoryPage(), // 商品分类页面
    ShoppingCartPage(), // 购物车页面
    UserPage(), // 用户信息页面
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: '分类',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '购物车',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '用户',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
