import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:flutter_chat/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? checklogin = false;
  bool isLoggedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      checkLoginandRedirect();
    });
  }

  void checkLoginandRedirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checklogin = prefs.getBool('isLoggedIn');
    if (mounted) {
      if (checklogin == true) {
        reDirectTo(context, () => ChatScreen(), state: this);
      } else {
        reDirectTo(context, () => WelcomeScreen('showData'), state: this);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            'assets/images/SellDoSplashScreen.png',
            fit: BoxFit.cover,
          ),
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: Text(
              "v9.1.0",
              style: TextStyle(
                fontSize: 23,
                color: Colors.white,
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}
