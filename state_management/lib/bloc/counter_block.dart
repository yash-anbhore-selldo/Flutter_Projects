import 'package:flutter_bloc/flutter_bloc.dart';

class Increment {}

class Decrement {}

class Reset {}

class CounterBloc extends Bloc<dynamic, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => (emit(state + 1)));
    on<Decrement>((event, emit) => (emit(state - 1)));
    on<Reset>((event, emit) => (emit(0)));
  }
}
