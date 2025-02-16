import 'package:flutter/material.dart';
import 'package:test_navigator/screen_2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  List<String> res = ["str"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Screen 1",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      final result = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Screen2();
                      }));

                      if (result != null) {
                        setState(() {
                          res = result;
                        });
                      }
                    },
                    child: Container(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Go to Screen 2",
                            style: TextStyle(fontSize: 22),
                          ),
                        )),
                  ),

                  // Text("Go to Screen 2"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              res.isNotEmpty
                  ? Column(
                      children: List.generate(
                          res.length, (index) => (Text(res[index]))))
                  : Text("No Data Found"),
            ]),
      ),
    );
  }
}
