import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../pages/search_page.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<dynamic> categories = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchCategories() async {
    setState(() {
      isLoading = true;
    });
    ApiService apiService = ApiService();
    try {
      final data = await apiService.fetchCategories();
      if (mounted) {
        setState(() {
          categories = data;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = '加载失败';
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text(categories[index]['cat_name']),
                      children: (categories[index]['children'] as List<dynamic>)
                          .map((child) => ListTile(
                                title: Text(child['cat_name']),
                                onTap: () {
                                  // 导航到搜索页面
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchPage(),
                                    ),
                                  );
                                },
                              ))
                          .toList(),
                    );
                  },
                ),
    );
  }
}
