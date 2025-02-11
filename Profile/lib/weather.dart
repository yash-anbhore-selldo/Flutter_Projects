import 'package:flutter/material.dart';
import 'weather_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _controller = TextEditingController();
  String _city = 'London';
  String _temperature = '';
  String _description = '';
  String _icon = '';
  bool _isLoading = false;
  final WeatherService _weatherService = WeatherService();

  void _getWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final weatherData = await _weatherService.getWeather(_city);
      setState(() {
        _temperature = '${weatherData['main']['temp']}°C';
        _description = weatherData['weather'][0]['description'];
        _icon = weatherData['weather'][0]['icon'];
      });
    } catch (e) {
      setState(() {
        _temperature = 'Error loading data';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter city',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) {
                  setState(() {
                    _city = _controller.text;
                  });
                  _getWeather();
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        Text(
                          _temperature,
                          style: TextStyle(fontSize: 36),
                        ),
                        Text(
                          _description,
                          style: TextStyle(fontSize: 24),
                        ),
                        Image.network(
                          'https://openweathermap.org/img/wn/$_icon@2x.png',
                        ),
                      ],
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getWeather,
                child: Text('Get Weather'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
