import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    );
  }
}
