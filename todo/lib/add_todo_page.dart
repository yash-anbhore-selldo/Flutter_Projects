import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/riverpod/todo_provider.dart';

class AddTodoPage extends ConsumerWidget {
  AddTodoPage({super.key});

  final todolistController = TextEditingController();

  final todo_desc_Controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: todolistController,
              decoration: InputDecoration(hintText: "TITLE"),
            ),
            TextField(
              controller: todo_desc_Controller,
              decoration: InputDecoration(hintText: "Description"),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  if (todolistController.text.isNotEmpty) {
                    ref.read(todoProvider.notifier).addTodo(
                        todolistController.text, todo_desc_Controller.text);

                    todolistController.clear();
                    todo_desc_Controller.clear();
                  }
                },
                child: Text("Add Data"))
          ],
        ),
      ),
    );
  }
}
