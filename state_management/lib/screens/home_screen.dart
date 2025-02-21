import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/provider/counter_provider.dart';
import 'package:state_management/provider/name_provider.dart';
import 'package:state_management/screens/showName_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nameProvider = Provider.of<NameProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Your Name"),
        centerTitle: true,
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  nameProvider.name = value;
                },
                decoration: InputDecoration(
                  labelText: "Enter Your Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Padding(
                        padding: const EdgeInsets.only(bottom: 300),
                        child: Container(
                          child: Center(
                            child: Text(
                              "Name Changed Successfully",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );

                  Future.delayed(Duration(seconds: 3));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShownameScreen(),
                    ),
                  );
                },
                child: Text("Go to nxt Screen "),
              ),
              Text(context.watch<CounterProvider>().counter.toString()),
              SizedBox(
                height: 280,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            context.read<CounterProvider>().incCounter();
                          },
                          child: Icon(Icons.add),
                        ),
                        MaterialButton(
                          onPressed: () {
                            context.read<CounterProvider>().resetCounter();
                          },
                          child: Icon(Icons.restart_alt_outlined),
                        ),
                        MaterialButton(
                          onPressed: () {
                            context.read<CounterProvider>().decCounter();
                          },
                          child: Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
