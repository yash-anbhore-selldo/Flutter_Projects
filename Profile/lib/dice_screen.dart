import 'dart:math';

import 'package:flutter/material.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  int left = 1;
  int right = 1;

  void randomNum() {
    setState(() {
      left = Random().nextInt(6) + 1;
      right = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Dice App',
            style: TextStyle(
              fontFamily: 'ShortBaby',
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 200.0, left: 10, right: 10),
          child: Column(children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.\,
              children: [
                Expanded(
                  child: Image.asset('assets/images/dice${left}.png'),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Image.asset('assets/images/dice$right.png'),
                  // child: Image.asset('images/dice2.png'),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () => {randomNum()},
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Le kar le Roll",
                  style: TextStyle(
                    fontFamily: 'ShortBaby',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
