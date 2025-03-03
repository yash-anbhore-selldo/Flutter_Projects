// // todo_model.dart
// class Todo {
//   String title;
//   String description;
//   final DateTime createdAt;
//   bool isCompleted;
//
//   Todo({
//     required this.title,
//     required this.description,
//     required this.createdAt,
//     this.isCompleted = false,
//   });
// }

class Todo {
  int? id;
  String title;
  String description;
  final DateTime createdAt;
  bool isCompleted;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.isCompleted = false,
  });

  // Convert Todo object to a map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  // Create a Todo object from a database map
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
