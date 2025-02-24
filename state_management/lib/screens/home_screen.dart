import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:state_management/bloc/counter_block.dart';
import 'package:state_management/provider/counter_provider.dart';
import 'package:state_management/provider/list_provider.dart';
import 'package:state_management/provider/name_provider.dart';
import 'package:state_management/screens/list_screen.dart';
import 'package:state_management/screens/showName_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final nameProvider = Provider.of<NameProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Your Name"),
        centerTitle: true,
      ),
      body: Wrap(children: [
        Expanded(
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
                // this is for provider
                Text(
                  context.watch<CounterProvider>().counter.toString(),
                ),
                //
                // this is Bloc
                BlocBuilder<CounterBloc, int>(
                  builder: (context, count) {
                    return Text(
                      '$count',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    );
                  },
                ),
                SizedBox(
                  height: 280,
                ),
                // Consumer<ListProvider>(builder: (context, provider, __) {
                //   var allData = provider.getData();
                //   return ListView(
                //
                //   )
                // }),
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
                              counterBloc.add(Increment());
                              context.read<CounterProvider>().incCounter();
                            },
                            child: Icon(Icons.add),
                          ),
                          MaterialButton(
                            onPressed: () {
                              counterBloc.add(Reset());
                              context.read<CounterProvider>().resetCounter();
                            },
                            child: Icon(Icons.restart_alt_outlined),
                          ),
                          MaterialButton(
                            onPressed: () {
                              counterBloc.add(Decrement());
                              context.read<CounterProvider>().decCounter();
                            },
                            child: Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
