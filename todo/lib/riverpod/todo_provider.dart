import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/model/todo_model.dart';

//http://bit.ly/43czKKe

//In this it has 2 thing
// 1. StateNotifier - It updates the state and notify listeners when state changes
// 2. StateNotifierProvider - makes the state accessible to the widget

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(String title, String description) {
    //the type of state is List<Todo> because StateNotifier<List<Todo>> initial super([]);
    state = [
      ...state,
      Todo(title: title, description: description, createdAt: DateTime.now())
    ];
  }

  void removeTodo(int index) {
    //test tht is it working properly it may only return the deleted ele.

    //check its not working
    // state = List.from(state).removeAt(index);

    // we can also do this
    //it gives an error for newlist as List<dynamic>
    //so specify the type
    //A value of type 'List<dynamic>'
    // can't be assigned to a variable of type 'List<Todo>
    final List<Todo> newlist = List.from(state);
    newlist.removeAt(index);
    state = newlist;
  }
}

//in StateNotifierProvider we provide the generic type of <TodoNotifier, List<Todo>>
final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});
