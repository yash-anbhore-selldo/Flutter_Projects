class Product {
  final int id;
  final String title; // Changed from 'name' to 'title'

  Product({required this.id, required this.title});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'], // Accessing 'title' instead of 'name'
    );
  }
}
