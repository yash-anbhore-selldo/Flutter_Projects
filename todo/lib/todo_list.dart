import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
      ),
      body: Expanded(
        //this takes blocType and stateType
        child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
          if (state is TodoInitial && state.todos.isEmpty) {
            return Center(
              child: Text("No Data Found"),
            );
          }
          final todos = (state as TodoInitial).todos;
          return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Color(0xFFfcf0bd),
                    child: ListTile(
                      title: Text(
                        todos[index].title,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        todos[index].description,
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            context.read<TodoBloc>().add(RemoveTodo(index));
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ),
                  ),
                );
              });
        }),
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
