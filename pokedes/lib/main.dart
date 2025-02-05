import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          foregroundColor: Colors.black87,
          title: Text("I am Batman"),
        ),

        // if we comment the appbar and the container have no child it will take all space
        body: SafeArea(
            child: Row(
          // verticalDirection: VerticalDirection.up,
          //it make even spaces in containers
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly

          // if we apply th crossAxisAl.stretch we dont need width it taks full screen
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
            ),
            for (var i = 0; i < 4; i++)
              Container(
                // height: 100,
                width: 90,
                // margin: EdgeInsets.only(top: 3, left: 100, bottom: 30),
                color: i % 2 == 0 ? Colors.blueAccent : Colors.orange,
                // transform:
                //     i % 2 == 0 ? Matrix4.rotationZ(0.2) : Matrix4.identity(),

                transform: 0 != 0 ? Matrix4.rotationZ(0.2) : Matrix4.identity(),

                padding: EdgeInsets.fromLTRB(18, 24, 1, 20),
                child: Text(
                  "data",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: i % 2 != 0 ? 29 : 32,
                  ),
                ),
              ),
          ],
        )),
      ),
    );
  }
}
