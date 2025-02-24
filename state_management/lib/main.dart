import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:state_management/bloc/counter_block.dart';
import 'package:state_management/provider/counter_provider.dart';
import 'package:state_management/provider/list_provider.dart';
import 'package:state_management/provider/name_provider.dart';
import 'package:state_management/screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NameProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CounterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ListProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //we wrap it in the BlocProvider so that we dont need to create
    //instance every time
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
