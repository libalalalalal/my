import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../pages/goods_detail_page.dart';

class FloorWidget extends StatefulWidget {
  @override
  _FloorWidgetState createState() => _FloorWidgetState();
}

class _FloorWidgetState extends State<FloorWidget> {
  List<dynamic> floorData = [];
  bool isLoading = true;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchFloorData();
  }

  void fetchFloorData() async {
    try {
      final data = await apiService.fetchFloorData();
      setState(() {
        floorData = data;
        isLoading = false;
      });
    } catch (e) {
      print('获取楼层数据出错: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void performSearch(String? url) {
    if (url != null && url.isNotEmpty) {
      String queryParam = Uri.parse(url).queryParameters['query'] ?? '';

      if (queryParam.isNotEmpty) {
        apiService.fetchFloorSearch(queryParam).then((searchResult) {
          setState(() {
            isLoading = false;
          });
          // 处理搜索结果
          print('搜索结果: $searchResult');

          // 导航到 GoodsDetailPage 并使用搜索结果的第一项商品
          if (searchResult['message']['goods'] != null &&
              searchResult['message']['goods'].isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GoodsDetailPage(
                  goodsId: searchResult['message']['goods'][0]['goods_id'],
                ),
              ),
            );
          } else {
            print('搜索结果中未找到商品');
          }
        }).catchError((e) {
          print('执行搜索时出错: $e');
          setState(() {
            isLoading = false;
          });
        });
      } else {
        print('缺少查询参数');
      }
    } else {
      print('导航 URL 为空或为 null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: floorData.map((floor) {
              if (floor != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (floor['floor_title'] != null &&
                        floor['floor_title']['image_src'] != null &&
                        floor['floor_title']['image_src'].isNotEmpty)
                      Image.network(
                        floor['floor_title']['image_src'],
                      )
                    else
                      Container(
                        width: 200,
                        height: 200,
                        color: Colors.grey, // 灰色占位符
                        child: Center(
                          child: Text('图片不可用'),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: (floor['product_list'] as List<dynamic>)
                          .map<Widget>((product) {
                        return GestureDetector(
                          onTap: () {
                            performSearch(product['navigator_url']);
                          },
                          child: Column(
                            children: [
                              if (product['image_src'] != null &&
                                  product['image_src'].isNotEmpty)
                                Image.network(
                                  product['image_src'],
                                  width: 100,
                                  height: 100,
                                )
                              else
                                Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey, // 灰色占位符
                                  child: Center(
                                    child: Text('图片不可用'),
                                  ),
                                ),
                              Text(
                                product['name'] ?? '',
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            }).toList(),
          );
  }
}
