import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/login_screen.dart';
import 'package:flutter_chat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  void redirectPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();

    animation =
        ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);
    // controller.reverse(from: 1.0);
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    controller.addListener(() {
      setState(() {});
      print('${animation.value}');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 300, left: 180),
              child: Column(
                children: [
                  Text(
                    "Center",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "Center",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 180),
            child: Text(
              "Version 9.0",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
