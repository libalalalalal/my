import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:OYY_APP/ui/pages/goods_detail_page.dart';

class SwiperWidget extends StatelessWidget {
  final List<dynamic> banners;

  SwiperWidget({required this.banners});

  void navigateToDetail(String navigatorUrl, BuildContext context) {
    Uri uri = Uri.parse(navigatorUrl);
    String? goodsIdString = uri.queryParameters['goods_id'];
    int? goodsId = int.tryParse(goodsIdString ?? '');
    if (goodsId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GoodsDetailPage(goodsId: goodsId),
        ),
      );
    } else {
      print('navigator_url 中未找到或无效的 goods_id: $navigatorUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: banners.map((item) {
        return GestureDetector(
          onTap: () {
            navigateToDetail(item['navigator_url'], context);
          },
          child: Builder(
            builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(
                    item['image_src'],
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
