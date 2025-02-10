import 'package:flutter/material.dart';
import 'package:test2/weather_service.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final weathercontroller = TextEditingController();
  String city = 'Mumbai';
  String temp = '';
  String desc = '';
  String icon = '';
  bool is_loading = false;

  void getWeather(String city) async {
    setState(() {
      is_loading = true;
    });
    try {
      final weatherData = await WeatherService().getWeather(city);
      setState(() {
        temp = '${weatherData['main']['temp']}°C';
        desc = weatherData['weather'][0]['description'];
        icon = weatherData['weather'][0]['icon'];
      });
    } catch (e) {
      setState(() {
        temp = 'Error loading data';
      });
    } finally {
      setState(() {
        is_loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFede2c2),
        appBar: AppBar(
          title: Text("Weather App"),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 200),
          child: Column(
            children: [
              TextField(
                controller: weathercontroller,
                decoration: InputDecoration(
                  labelText: 'Enter City ',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) {
                  setState(() {
                    city = weathercontroller.text;
                  });
                  getWeather(city);
                },
              ),
              SizedBox(
                height: 20,
              ),
              is_loading
                  ? CircularProgressIndicator()
                  : Row(
                      children: [
                        Image.network(
                          'https://openweathermap.org/img/wn/$icon@2x.png',
                        ),
                        Text(
                          temp,
                          style: TextStyle(fontSize: 36),
                        ),
                        Text(
                          desc,
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
