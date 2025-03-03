import 'package:todo/database/db_helper.dart';
import 'package:todo/model/todo_model.dart';

//this is at repo level
class TodoRepository {
  final dbHelper = DBHelper.dbHero;

  Future<int> insertTodo(Todo todo) async {
    return await dbHelper.insertDb(todo.toMap());
  }

  Future<List<Todo>> getAllTodos() async {
    final List<Map<String, dynamic>> maps = await dbHelper.readDb();
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  Future<int> updateTodo(Todo todo) async {
    return await dbHelper.updateDb(todo.toMap());
  }

  Future<int> deleteTodo(int id) async {
    return await dbHelper.deleteDb(id);
  }
}
