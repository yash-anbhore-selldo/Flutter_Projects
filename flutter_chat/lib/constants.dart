import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  fillColor: Colors.black,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

void reDirectTo(BuildContext context, Widget Function() screenBuilder,
    {State? state}) {
  if (state?.mounted ?? true) {
    // If state is provided, check mounted, otherwise proceed
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => screenBuilder(),
      ),
    );
  }
}
