import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/model/todo_model.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final todolistController = TextEditingController();
  final todo_desc_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    context.read<TodoBloc>().add(
                          AddTodo(Todo(
                            title: todolistController.text,
                            description: todo_desc_Controller.text,
                            createdAt: DateTime.now(),
                          )),
                        );
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
