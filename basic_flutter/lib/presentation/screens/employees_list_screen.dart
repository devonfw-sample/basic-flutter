import 'package:basic_flutter/main.dart';
import 'package:flutter/material.dart';

import '../../data/dummy_class.dart';
import '../widgets/list_item.dart';

class EmployeesListScreen extends StatelessWidget {
  static const String routeName = "/employees-list-screen";

  const EmployeesListScreen({Key? key}) : super(key: key);

  void _switchToEmployeePage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyHomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Employees List",
              style: Theme.of(context).textTheme.headline6),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return ListItem(
                index: index, switchToEmployeePage: _switchToEmployeePage);
          },
          itemCount: DummyClass.dummyList.length,
        ));
  }
}
