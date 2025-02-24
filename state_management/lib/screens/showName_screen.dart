import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:state_management/bloc/counter_block.dart';
import 'package:state_management/provider/name_provider.dart';

class ShownameScreen extends StatelessWidget {
  const ShownameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameProvider = Provider.of<NameProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(nameProvider.name),
      ),
      body: BlocBuilder<CounterBloc, int>(
        builder: (context, count) {
          return Center(
            child: Text(
              "Count : $count",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          );
        },
      ),
    );
  }
}
