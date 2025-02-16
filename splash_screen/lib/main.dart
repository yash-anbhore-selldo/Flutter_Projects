import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          body: Stack(
        children: [
          //if we dont add SB it wont work(image dont take whole screen)
          SizedBox.expand(
            child: Image.asset(
              'asset/images/SellDoSplashScreen.png',
              fit: BoxFit.cover,
            ),
          ),

          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Text(
                  "Sell Faster",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Text(
                "v9.3",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          )
        ],
      )),
    );
  }
}
