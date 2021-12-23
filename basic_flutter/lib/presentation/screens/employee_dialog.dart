import 'package:flutter/material.dart';

class EmployeeDialog extends StatelessWidget {
  const EmployeeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Employee dialog'),
          centerTitle: true,
        ),
        body: const Center(child: Text('Employee Dialog')));
  }
}
