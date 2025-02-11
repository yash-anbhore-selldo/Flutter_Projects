import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'af729fbb244258b421b3465886ec1c27';

  Future<Map<String, dynamic>> getWeather(String city) async {
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load Data");
    }
  }
}
