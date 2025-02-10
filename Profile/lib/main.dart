import 'package:flutter/material.dart';
import 'package:test2/bmi_calculator.dart';
import 'package:test2/dice_screen.dart';
import 'package:test2/musicapp.dart';
import 'package:test2/note.dart';
import 'package:test2/quiz_app.dart';
import 'package:test2/test.dart';
import 'package:test2/weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget buildCard(IconData icon, String text, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      color: Colors.white10,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        title: Text(
          text,
          style: TextStyle(
              fontFamily: 'ShortBaby', fontSize: 18, color: Colors.white),
        ),
        trailing: Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white54,
        ),
        onTap: () {
          // Directly use the context from the onTap callback
          if (text == "Dice Game") {
            // Navigator.push is used with the context here directly
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiceScreen()),
            );
          } else if (text == "Weather") {
            // Navigator.push is used with the context here directly
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WeatherScreen()),
            );
          } else if (text == "Note") {
            // Navigator.push is used with the context here directly
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WeatherScreen()),
            );
          } else if (text == "Quiz App") {
            // Navigator.push is used with the context here directly
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizApp()),
            );
          } else if (text == "Bmi") {
            // Navigator.push is used with the context here directly
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BmiCalculator()),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white10,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                trailing: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(
                    Icons.light_mode,
                    color: Colors.black,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile_pic.jpg'),
              ),
              SizedBox(height: 10),
              Text(
                "Yash Anbhore",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'ShortBaby'),
              ),
              Text(
                "yash_anbohre@sell.do",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white70,
                    fontSize: 15,
                    fontFamily: 'ShortBaby'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Builder(
                  builder: (context) {
                    return ListView(
                      children: [
                        buildCard(Icons.person, "Dice Game", context),
                        SizedBox(height: 5),
                        buildCard(Icons.share, "Weather", context),
                        SizedBox(height: 5),
                        buildCard(Icons.settings, "Note", context),
                        SizedBox(height: 5),
                        buildCard(Icons.help, "Quiz App", context),
                        SizedBox(height: 5),
                        buildCard(Icons.logout, "Bmi", context),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
