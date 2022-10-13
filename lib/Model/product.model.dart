class Product {
  String? name;
  String? description;
  double? price;
  bool? available;

  Product({
    required String this.name,
    required String this.description,
    required double this.price,
    required bool this.available,
  });

  Product.fromMap(Map<String, dynamic> product) {
    name = product['name'];
    description = product['description'];
    price = product['price'];
    available = product['available'];
  }
}
