// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo/database/todo_repo.dart';
// import 'package:todo/model/todo_model.dart';
//
// final todoRepositoryProvider = Provider<TodoRepository>((ref) {
//   return TodoRepository();
// });
//
// class TodoNotifier extends StateNotifier<List<Todo>> {
//   final TodoRepository _repository;
//
//   TodoNotifier(this._repository) : super([]) {
//     loadTodos();
//   }
//
//   Future<void> loadTodos() async {
//     final todos = await _repository.getAllTodos();
//     state = todos;
//   }
//
//   Future<void> addTodo(
//       String title, String description, DateTime datetime) async {
//     final todo =
//         Todo(title: title, description: description, createdAt: datetime);
//
//     final id = await _repository.insertTodo(todo);
//     todo.id = id;
//
//     state = [...state, todo];
//   }
//
//   Future<void> toggleTodoStatus(int index) async {
//     final List<Todo> updatedList = List.from(state);
//     final todo = updatedList[index];
//
//     final updatedTodo = Todo(
//       id: todo.id,
//       title: todo.title,
//       description: todo.description,
//       createdAt: todo.createdAt,
//       isCompleted: !todo.isCompleted,
//     );
//
//     await _repository.updateTodo(updatedTodo);
//     updatedList[index] = updatedTodo;
//     state = updatedList;
//   }
//
//   Future<void> editTodo(int index, String title, String description) async {
//     final List<Todo> updatedList = List.from(state);
//     final todo = updatedList[index];
//
//     final updatedTodo = Todo(
//       id: todo.id,
//       title: title,
//       description: description,
//       createdAt: todo.createdAt,
//       isCompleted: todo.isCompleted,
//     );
//
//     await _repository.updateTodo(updatedTodo);
//     updatedList[index] = updatedTodo;
//     state = updatedList;
//   }
//
//   Future<void> removeTodo(int index) async {
//     final List<Todo> newlist = List.from(state);
//     final todo = newlist[index];
//
//     if (todo.id != null) {
//       await _repository.deleteTodo(3);
//     }
//
//     newlist.removeAt(index);
//     state = newlist;
//   }
// }
//
// final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
//   final repository = ref.watch(todoRepositoryProvider);
//   return TodoNotifier(repository);
// });
