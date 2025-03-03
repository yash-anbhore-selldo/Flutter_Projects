import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/database/todo_repo.dart';
import 'package:todo/model/todo_model.dart';

//https://shorturl.at/u86Nt

// Events
abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;
  final DateTime dateTime;

  AddTodoEvent({
    required this.title,
    required this.description,
    required this.dateTime,
  });
}

class ToggleTodoStatusEvent extends TodoEvent {
  final int index;

  ToggleTodoStatusEvent(this.index);
}

class EditTodoEvent extends TodoEvent {
  final int index;
  final String title;
  final String description;

  EditTodoEvent({
    required this.index,
    required this.title,
    required this.description,
  });
}

class RemoveTodoEvent extends TodoEvent {
  final int index;

  RemoveTodoEvent(this.index);
}

// States
abstract class TodoState {}

class TodoLoadingState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List<Todo> todos;

  TodoLoadedState(this.todos);
}

class TodoErrorState extends TodoState {
  final String message;

  TodoErrorState(this.message);
}

// BLoC
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository = TodoRepository();

  TodoBloc() : super(TodoLoadingState()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<ToggleTodoStatusEvent>(_onToggleTodoStatus);
    on<EditTodoEvent>(_onEditTodo);
    on<RemoveTodoEvent>(_onRemoveTodo);

    // Load todos when bloc is created
    add(LoadTodos());
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    //emit is used to update the state
    //now our state is in loading if we want to render loading animation we can do tht
    // it is similar to a conditional redering logic we just use class instead of var
    emit(TodoLoadingState());
    try {
      final todos = await _repository.getAllTodos();
      emit(TodoLoadedState(todos));
    } catch (e) {
      emit(TodoErrorState('Failed to load todos: $e'));
    }
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    try {
      //it checks that the state is an instance of the todoloadedstate
      if (state is TodoLoadedState) {
        //state is of type TodoState so cast it to TodoLoadedState
        final currentTodos = (state as TodoLoadedState).todos;

        final todo = Todo(
          title: event.title,
          description: event.description,
          createdAt: event.dateTime,
        );

        final id = await _repository.insertTodo(todo);
        todo.id = id;

        emit(TodoLoadedState([...currentTodos, todo]));
      }
    } catch (e) {
      emit(TodoErrorState('Failed to add todo: $e'));
    }
  }

  Future<void> _onToggleTodoStatus(
      ToggleTodoStatusEvent event, Emitter<TodoState> emit) async {
    try {
      if (state is TodoLoadedState) {
        final currentTodos = List<Todo>.from((state as TodoLoadedState).todos);
        final todo = currentTodos[event.index];

        final updatedTodo = Todo(
          id: todo.id,
          title: todo.title,
          description: todo.description,
          createdAt: todo.createdAt,
          isCompleted: !todo.isCompleted,
        );

        await _repository.updateTodo(updatedTodo);
        currentTodos[event.index] = updatedTodo;

        emit(TodoLoadedState(currentTodos));
      }
    } catch (e) {
      emit(TodoErrorState('Failed to toggle todo status: $e'));
    }
  }

  Future<void> _onEditTodo(EditTodoEvent event, Emitter<TodoState> emit) async {
    try {
      if (state is TodoLoadedState) {
        final currentTodos = List<Todo>.from((state as TodoLoadedState).todos);
        final todo = currentTodos[event.index];

        final updatedTodo = Todo(
          id: todo.id,
          title: event.title,
          description: event.description,
          createdAt: todo.createdAt,
          isCompleted: todo.isCompleted,
        );

        await _repository.updateTodo(updatedTodo);
        currentTodos[event.index] = updatedTodo;

        emit(TodoLoadedState(currentTodos));
      }
    } catch (e) {
      emit(TodoErrorState('Failed to edit todo: $e'));
    }
  }

  Future<void> _onRemoveTodo(
      RemoveTodoEvent event, Emitter<TodoState> emit) async {
    try {
      if (state is TodoLoadedState) {
        final currentTodos = List<Todo>.from((state as TodoLoadedState).todos);
        final todo = currentTodos[event.index];

        if (todo.id != null) {
          await _repository.deleteTodo(todo.id!);
        }

        currentTodos.removeAt(event.index);
        emit(TodoLoadedState(currentTodos));
      }
    } catch (e) {
      emit(TodoErrorState('Failed to remove todo: $e'));
    }
  }
}
