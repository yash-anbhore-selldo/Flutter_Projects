import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product.dart';

//fetches product data from an external API and returns it as a list of Product objects.
class ApiService {
  static const String _baseUrl = 'https://dummyjson.com/products';
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['products'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed");
    }
  }
}
