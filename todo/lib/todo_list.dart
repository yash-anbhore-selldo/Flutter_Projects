import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/riverpod/todo_provider.dart';

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // this listen for the todoProvider
    final todos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
      ),
      body: Expanded(
        child: todos.isEmpty
            ? Text("No Data Found")
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Color(0xFFFFF0BD),
                          child: ListTile(
                            leading: Text(
                              todos[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            title: Text(
                              todos[index].description,
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: IconButton(
                              onPressed: () => ref
                                  .read(todoProvider.notifier)
                                  .removeTodo(index),
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addtodo');
        },
        tooltip: "Add To Do",
        child: Icon(Icons.add),
      ),
    );
  }
}
