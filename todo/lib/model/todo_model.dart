// todo_model.dart
class Todo {
  String title;
  String description;
  final DateTime createdAt;
  bool isCompleted;

  Todo({
    required this.title,
    required this.description,
    required this.createdAt,
    this.isCompleted = false,
  });
}
