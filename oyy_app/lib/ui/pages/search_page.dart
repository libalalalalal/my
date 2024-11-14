import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import 'goods_detail_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> goods = [];
  bool isLoading = false;
  String query = '';

  ApiService apiService = ApiService();

  void searchGoods() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await apiService.fetchGoodsList(query: query);
      setState(() {
        goods = data;
        isLoading = false;
      });
    } catch (e) {
      print('goods错误: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('搜索失败，请稍后重试'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: '搜索商品...',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            setState(() {
              query = value;
            });
            searchGoods();
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : goods.isEmpty
              ? Center(
                  child: Text('没有搜索到相关商品'),
                )
              : ListView.builder(
                  itemCount: goods.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(goods[index]['goods_name']),
                      subtitle: Text('￥${goods[index]['goods_price']}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoodsDetailPage(
                              goodsId: goods[index]['goods_id'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
