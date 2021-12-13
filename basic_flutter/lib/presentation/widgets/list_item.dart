import 'package:flutter/material.dart';

import '../../data/employee.dart';
import '../../data/routes.dart';

class ListItem extends StatelessWidget {
  static const String employeesInsertEndpoint =
      'https://app.swaggerhub.com/apis/flutterteam2/basic-flutter/1.0.0#/employeemanagement/v1/employee';
  const ListItem({Key? key, required this.index, required this.employeeList})
      : super(key: key);

  final int index;
  final List<Employee> employeeList;

  void _switchToEmployeePage(BuildContext context) {
    Navigator.pushNamed(context, Routes.employeeDialogRouteName);
  }


  void _switchToEmployeePage(BuildContext context) {
    Navigator.pushNamed(context, Routes.employeeDialogRouteName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _switchToEmployeePage(context);
        },
        child: Card(
          elevation: 10,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  '${employeeList[index].firstName} ${employeeList[index].lastName} ',
                  style: Theme.of(context).textTheme.headline6),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                employeeList[index].email,
                style: const TextStyle(
                    fontFamily: "Raleway-ExtraBold", fontSize: 16),
                softWrap: true,
              ),
            ),
            trailing: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.delete_forever),
                label: const Text("Delete"),
                style: TextButton.styleFrom(
                    primary: Theme.of(context).errorColor)),
          ),
        ));
  }
}
