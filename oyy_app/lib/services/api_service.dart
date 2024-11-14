import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:OYY_APP/models/models.dart';

class ApiService {
  final String baseUrl = 'https://api-hmugo-web.itheima.net/api/public/v1';

  // // 发送短信验证码
  // Future<void> sendSmsCaptcha(String mobile) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/captcha/sendSmsCaptcha'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'platform': 'H5',
  //     },
  //     body: json.encode({
  //       'mobile': mobile,
  //     }),
  //   );

  //   if (response.statusCode != 200) {
  //     throw Exception('发送短信验证码失败');
  //   }
  // }

  // // 登录或注册
  // Future<UserInfo> loginOrRegister(String mobile, String smsCode) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/passport/login'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'platform': 'H5',
  //     },
  //     body: json.encode({
  //       'form': {
  //         'smsCode': smsCode,
  //         'mobile': mobile,
  //         'isParty': false,
  //         'partyData': {},
  //       },
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     return UserInfo.fromJson(data['data']['userInfo']);
  //   } else {
  //     throw Exception('登录或注册失败');
  //   }
  // }

  // 获取轮播图数据
  Future<List<dynamic>> fetchSwiperData() async {
    final response = await http.get(Uri.parse('$baseUrl/home/swiperdata'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('加载轮播图数据失败');
    }
  }

  // 获取分类项数据
  Future<List<dynamic>> fetchCatItems() async {
    final response = await http.get(Uri.parse('$baseUrl/home/catitems'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('加载分类项数据失败');
    }
  }

  // 获取楼层数据
  Future<List<dynamic>> fetchFloorData() async {
    final response = await http.get(Uri.parse('$baseUrl/home/floordata'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('加载楼层数据失败');
    }
  }

  // 搜索商品
  Future<Map<String, dynamic>> fetchFloorSearch(String query) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/goods/search?query=$query'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('搜索失败');
      }
    } catch (e) {
      throw Exception('搜索错误: $e');
    }
  }

  // 获取商品分类列表
  Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('加载商品分类失败');
    }
  }

  // 搜索商品
  Future<Map<String, dynamic>> fetchGoodsSearch({
    required String query,
  }) async {
    final response =
        await http.get(Uri.parse('$baseUrl/goods/search?query=$query'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('加载商品失败');
    }
  }

  // 获取搜索结果的商品列表
  Future<List<dynamic>> fetchGoodsListFromSearch() async {
    final response = await http.get(Uri.parse('$baseUrl/goods/search?query=1'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message']['goods'];
    } else {
      throw Exception('加载搜索结果商品列表失败');
    }
  }

  // 获取商品列表
  Future<List<dynamic>> fetchGoodsList({
    required String query,
    String cid = '',
    int pageNum = 1,
    int pageSize = 10,
  }) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/goods/search?query=$query&cid=$cid&pagenum=$pageNum&pagesize=$pageSize'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message']['goods'];
    } else {
      throw Exception('加载商品列表失败');
    }
  }

  // 获取商品详情
  Future<Map<String, dynamic>> fetchGoodsDetail(int goodsId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/goods/detail?goods_id=$goodsId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('加载商品详情失败');
    }
  }

  // 添加商品到购物车
  Future<Map<String, dynamic>> addToCart({
    required String accessToken,
    required String platform,
    required String goodsId,
    int goodsNum = 1,
    String? goodsSkuId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cart/add'),
      headers: {
        'Content-Type': 'application/json',
        'Access-Token': accessToken,
        'platform': platform,
      },
      body: json.encode({
        'goodsId': goodsId,
        'goodsNum': goodsNum,
        'goodsSkuId': goodsSkuId ?? '0',
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('添加到购物车失败');
    }
  }

  // 获取首页数据
  Future<Map<String, dynamic>> fetchHomePageData() async {
    final response = await http.get(Uri.parse('$baseUrl/home'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('加载首页数据失败');
    }
  }

  // 创建订单
  Future<Map<String, dynamic>> createOrder({
    required String accessToken,
    required String orderPrice,
    required String consigneeAddr,
    required List<Map<String, dynamic>> goods,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/my/orders/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': accessToken,
      },
      body: json.encode({
        'order_price': orderPrice,
        'consignee_addr': consigneeAddr,
        'goods': goods,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['error_code'] == 0) {
        return data['data'];
      } else {
        throw Exception('创建订单失败: ${data['message']}');
      }
    } else {
      throw Exception('创建订单失败: 网络请求错误');
    }
  }

  // 获取购物车商品
  Future<Map<String, dynamic>> getCartItems(String accessToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/cart/items'),
      headers: {
        'Authorization': accessToken,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('获取购物车商品失败');
    }
  }

  // 获取订单列表
  Future<Map<String, dynamic>> getOrders(String accessToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/my/orders/all'),
      headers: {
        'Authorization': accessToken,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('获取订单列表失败');
    }
  }
}
