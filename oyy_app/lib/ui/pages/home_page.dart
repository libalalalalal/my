import 'package:OYY_APP/services/api_service.dart';
import 'package:OYY_APP/ui/widgets/swiper_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/floor_widget.dart';
import 'goods_detail_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> goodsList = [];
  List<dynamic> banners = [];
  bool isLoading = false;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchHomePageData();
  }

  void fetchHomePageData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final bannerData = await apiService.fetchSwiperData();
      final goodsData = await apiService.fetchGoodsListFromSearch();

      setState(() {
        banners = bannerData;
        goodsList = goodsData;
        isLoading = false;
      });
    } catch (e) {
      print('获取主页错误: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主页'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SwiperWidget(banners: banners),
                  SizedBox(height: 10),
                  FloorWidget(),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: goodsList.length,
                    itemBuilder: (context, index) {
                      var goods = goodsList[index];
                      return ListTile(
                        title: Text(goods['goods_name']),
                        subtitle: Text('Price: \$${goods['goods_price']}'),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(goods['goods_big_logo']),
                          backgroundColor: Colors.grey,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GoodsDetailPage(
                                goodsId: goods['goods_id'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
