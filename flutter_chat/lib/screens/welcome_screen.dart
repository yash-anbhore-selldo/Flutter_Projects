import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/login_screen.dart';
import 'package:flutter_chat/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  final String showData;

  const WelcomeScreen(this.showData, {Key? key}) : super(key: key);

  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _navigateToScreen(Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false, // Removes all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Remote Config: ${widget.showData}",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 60.0,
                      child: Image.asset(
                        'images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ScaleTransition(
                    scale: animation,
                    child: const Text(
                      'Flash Chat',
                      style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () => _navigateToScreen(LoginScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Log In',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () => _navigateToScreen(RegistrationScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
