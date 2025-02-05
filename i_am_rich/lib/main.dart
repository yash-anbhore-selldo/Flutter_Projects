import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.black87,
        title: Text("I am Batman"),
      ),
      body: Center(
          child: Image(
        image: AssetImage('images/batman.jpg'),
      )),
    ),
  ));
}
