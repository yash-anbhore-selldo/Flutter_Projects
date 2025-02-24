import 'package:bloc/bloc.dart';
import 'package:todo/model/todo_model.dart';

abstract class TodoEvent {}

//---------- Events -----------
class AddTodo extends TodoEvent {
  final Todo todo;
  AddTodo(this.todo);
}

class RemoveTodo extends TodoEvent {
  final int index;
  RemoveTodo(this.index);
}

// -------- States --------
abstract class TodoState {}

class TodoInitial extends TodoState {
  final List<Todo> todos;
  TodoInitial(this.todos);
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial([])) {
    on<AddTodo>((event, emit) {
      final updatedTodos = List<Todo>.from((state as TodoInitial).todos)
        ..add(event.todo);
      emit(TodoInitial(updatedTodos));
    });
    on<RemoveTodo>((event, emit) {
      final updatedTodos = List<Todo>.from((state as TodoInitial).todos)
        ..removeAt(event.index);
      emit(TodoInitial(updatedTodos));
    });
  }
}
