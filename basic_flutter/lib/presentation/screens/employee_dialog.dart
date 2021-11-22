import 'package:flutter/material.dart';

class EmployeeDialog extends StatelessWidget {
  const EmployeeDialog({Key? key}) : super(key: key);
  static const routeName = '/employee-dialog';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Employee dialog"),
          centerTitle: true,
        ),
        body: Center(child: Text("Employee Dialog")));
  }
}
