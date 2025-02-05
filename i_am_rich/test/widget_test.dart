import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App displays Batman text and image', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(
      MaterialApp(
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
              ),)
        ),
      ),
    );

    // Verify "I am Batman" is displayed
    expect(find.text("I am Batman"), findsOneWidget);

    // Verify the image exists
    expect(find.byType(Image), findsOneWidget);
  });
}
