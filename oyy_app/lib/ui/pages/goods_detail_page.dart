import 'package:flutter/material.dart';

import 'shopping_cart_page.dart';
import '../../services/api_service.dart';

class GoodsDetailPage extends StatefulWidget {
  final int goodsId;

  GoodsDetailPage({required this.goodsId});

  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  Map<String, dynamic>? goodsDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGoodsDetail();
  }

  void fetchGoodsDetail() async {
    ApiService apiService = ApiService();
    try {
      final data = await apiService.fetchGoodsDetail(widget.goodsId);
      setState(() {
        goodsDetail = data;
        isLoading = false;
      });
    } catch (e) {
      print('获取商品详情错误: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void addToCart() {
    if (goodsDetail != null) {
      ShoppingCartPage.addToCart(goodsDetail!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('商品已加入购物车'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : goodsDetail == null
              ? Center(child: Text('商品信息加载失败'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goodsDetail!['goods_name'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          '￥${goodsDetail!['goods_price']}',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 16),
                        if (goodsDetail!['pics'] != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: goodsDetail!['pics']
                                .map<Widget>(
                                  (pic) => Image.network(pic['pics_big']),
                                )
                                .toList(),
                          ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 56.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: addToCart,
                  child: Text('加入购物车'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
