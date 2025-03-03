import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginatedListScreen(),
    );
  }
}

class PaginatedListScreen extends StatefulWidget {
  const PaginatedListScreen({super.key});

  @override
  _PaginatedListScreenState createState() => _PaginatedListScreenState();
}

class _PaginatedListScreenState extends State<PaginatedListScreen> {
  List<dynamic> items = [];
  int page = 1;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchItems();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchItems();
      }
    });
  }

  Future<void> fetchItems() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    final response = await http.get(Uri.parse(
        //in this we are setting the limit to 10
        // and the page part tell me page one has 1-10, page 2 has 11-20
        'https://jsonplaceholder.typicode.com/posts?_limit=10&_page=$page'));
    if (response.statusCode == 200) {
      List newItems = json.decode(response.body);
      setState(() {
        items.addAll(newItems);
        page++;
      });
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paginated List')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == items.length) {
            return isLoading
                ? const Center(
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator()))
                : const SizedBox();
          }
          return ListTile(
            title: Text(items[index]['title']),
            subtitle: Text(items[index]['body']),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
