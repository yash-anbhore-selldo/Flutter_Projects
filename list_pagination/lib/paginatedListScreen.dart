import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Paginatedlistscreen extends StatefulWidget {
  const Paginatedlistscreen({super.key});

  @override
  State<Paginatedlistscreen> createState() => _PaginatedlistscreenState();
}

class _PaginatedlistscreenState extends State<Paginatedlistscreen> {
  List<dynamic> items = [];
  int page = 1;
  bool isLoading = true;
  ScrollController sc = ScrollController();

  void fetch() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    final url =
        'https://jsonplaceholder.typicode.com/posts?_limit=10&_page=$page';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List newitem = jsonDecode(response.body);
      setState(() {
        items.addAll(newitem);
        page++;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
    sc.addListener(() {
      if (sc.position.hasPixels == sc.position.maxScrollExtent) {
        fetch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paginated List"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          controller: sc,
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == items.length) {
              return CircularProgressIndicator();
            }
            return Column(
              children: [
                Text(
                  items[index]['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(items[index]['body']),
              ],
            );
          },

          // Column(
          //   children: [Text("")],
          // ),
        ),
      ),
    );
  }
}
