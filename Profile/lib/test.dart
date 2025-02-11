import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test2/weather_service.dart';
import 'package:geocoding/geocoding.dart';

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

  int pressure = 0;
  int humidity = 0;
  double dewpoint = 0.0;
  double windspeed = 0.0;

  bool is_loading = true;
  double lat = 0.0;
  double long = 0.0;

  var humidData;

  void getWeather(String city) async {
    setState(() {
      is_loading = false;
    });
    try {
      final weatherData = await WeatherService().getWeather(city);
      print(weatherData);
      setState(() {
        temp = '${weatherData['main']['temp']}°';
        desc = weatherData['weather'][0]['description'];
        icon = weatherData['weather'][0]['icon'];

        humidity = weatherData['main']['humidity'];
        windspeed = weatherData['wind']['speed'];
        pressure = weatherData['main']['pressure'];
      });
    } catch (e) {
      setState(() {
        temp = 'E';
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 200),
            child: Column(
              children: [
                TextField(
                  controller: weathercontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter City ',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) async {
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
                    : Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                is_loading
                                    ? CircularProgressIndicator()
                                    : Image.network(
                                        'https://openweathermap.org/img/wn/$icon@2x.png',
                                      ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      city,
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      desc,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'ShortBaby'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  temp,
                                  style: TextStyle(fontSize: 33),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Icon(Icons.air,
                                              color: Colors
                                                  .blue), // Wind speed icon
                                          Text(
                                            '${windspeed.toString()} m/s',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            "WindSpeed",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Icon(Icons.water_drop,
                                              color:
                                                  Colors.blue), // Humidity icon
                                          Text(
                                            '${humidity.toString()}%',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            "Humidity",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Icon(Icons.speed,
                                              color:
                                                  Colors.blue), // Pressure icon
                                          Text(
                                            '${pressure.toString()} hPa',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            "Pressure",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
