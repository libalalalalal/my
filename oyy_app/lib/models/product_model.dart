// product_model.dart

class Product {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['goods_id'],
      name: json['goods_name'],
      imageUrl: json['goods_image'],
      price: double.parse(json['goods_price_min']),
      stock: json['stock_total'],
    );
  }
}
