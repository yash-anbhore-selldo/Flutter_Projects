import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/provider/list_provider.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> mdata = context.watch<ListProvider>().getData();
    return Scaffold(
      body: Consumer<ListProvider>(builder: (context, provider, __) {
        var allData = provider.getData();
        return ListTile(
            title: Text(
          "allData[0]['name']",
          style: TextStyle(color: Colors.black),
        ));
      }),
    );
  }
}
