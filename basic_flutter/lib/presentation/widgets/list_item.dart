import 'package:flutter/material.dart';

import '../../data/employee.dart';
import '../../data/routes.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.employee, required this.deleteEntry})
      : super(key: key);

  final Employee employee;
  final VoidCallback deleteEntry;

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
              child: Text('${employee.firstName} ${employee.lastName} ',
                  style: Theme.of(context).textTheme.headline6),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                employee.email,
                style: const TextStyle(
                    fontFamily: 'Raleway-ExtraBold', fontSize: 16),
                softWrap: true,
              ),
            ),
            trailing: TextButton.icon(
                onPressed: () => deleteEntry,
                icon: const Icon(Icons.delete_forever),
                label: const Text('Delete'),
                style: TextButton.styleFrom(
                    primary: Theme.of(context).errorColor)),
          ),
        ));
  }
}
