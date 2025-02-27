import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/riverpod/todo_provider.dart';
import 'package:intl/intl.dart'; // Add this package for date formatting

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
      body: todos.isEmpty
          ? Center(child: Text("No Data Found"))
          : Padding(
              padding: EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF0BD),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: () => _showTodoDetailsBottomSheet(
                            context, ref, index, todo),
                        leading: Checkbox(
                          value: todo.isCompleted,
                          onChanged: (_) {
                            ref
                                .read(todoProvider.notifier)
                                .toggleTodoStatus(index);
                          },
                        ),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat('MMM dd, yyyy - hh:mm a')
                              .format(todo.createdAt),
                          style: TextStyle(
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showEditTodoBottomSheet(
                                  context, ref, index, todo),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  _confirmDeleteTodo(context, ref, index),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoBottomSheet(context, ref),
        tooltip: "Add To Do",
        child: Icon(Icons.add),
      ),
    );
  }

  void _confirmDeleteTodo(BuildContext context, WidgetRef ref, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Todo'),
        content: Text('Are you sure you want to delete this todo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(todoProvider.notifier).removeTodo(index);
              Navigator.pop(context);
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showTodoDetailsBottomSheet(
      BuildContext context, WidgetRef ref, int index, Todo todo) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Todo Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.pop(context);
                        _showEditTodoBottomSheet(context, ref, index, todo);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Navigator.pop(context);
                        _confirmDeleteTodo(context, ref, index);
                      },
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            ListTile(
              title: Text('Status'),
              trailing: Chip(
                label: Text(
                  todo.isCompleted ? 'Completed' : 'Pending',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor:
                    todo.isCompleted ? Colors.green : Colors.orange,
              ),
              onTap: () {
                ref.read(todoProvider.notifier).toggleTodoStatus(index);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Title'),
              subtitle: Text(
                todo.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text('Description'),
              subtitle: Text(
                todo.description.isEmpty ? 'No description' : todo.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              title: Text('Created At'),
              subtitle: Text(
                DateFormat('EEEE, MMMM dd, yyyy - hh:mm a')
                    .format(todo.createdAt),
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showEditTodoBottomSheet(
      BuildContext context, WidgetRef ref, int index, Todo todo) {
    final titleController = TextEditingController(text: todo.title);
    final descController = TextEditingController(text: todo.description);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit Todo',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    ref.read(todoProvider.notifier).toggleTodoStatus(index);
                  },
                ),
                Text('Completed'),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    ref.read(todoProvider.notifier).editTodo(
                          index,
                          titleController.text,
                          descController.text,
                        );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Title cannot be empty'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Keep your existing _showAddTodoBottomSheet method

  void _showAddTodoBottomSheet(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final ValueNotifier<DateTime?> selectedDateTime = ValueNotifier(null);

    showMaterialModalBottomSheet(
      context: context,
      expand: false,
      isDismissible: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create New Todo',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Enter todo title',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter todo description',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ValueListenableBuilder<DateTime?>(
              valueListenable: selectedDateTime,
              builder: (context, dateTime, _) {
                return InkWell(
                  onTap: () {
                    DatePicker.showDateTimePicker(
                      context,
                      onConfirm: (date) {
                        selectedDateTime.value = date;
                      },
                      currentTime: DateTime.now(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            dateTime == null
                                ? 'Set date and time'
                                : 'Date: ${dateTime.day}/${dateTime.month}/${dateTime.year} - Time: ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      selectedDateTime.value != null) {
                    ref.read(todoProvider.notifier).addTodo(
                          titleController.text,
                          descController.text,
                          selectedDateTime.value!,
                        );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all required fields'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text(
                  'Add Todo',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
