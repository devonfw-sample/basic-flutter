import 'package:flutter/material.dart';

import '../../data/employee.dart';
import '../../data/routes.dart';

class EmployeeGridItem extends StatelessWidget {
  const EmployeeGridItem({Key? key, required this.indexedEmployee})
      : super(key: key);

  final Employee indexedEmployee;

  void _switchToEmployeePage(BuildContext context) {
    Navigator.pushNamed(context, Routes.employeeDialogRouteName,
        arguments: indexedEmployee);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _switchToEmployeePage(context),
      child: GridTile(
          child: Text('${indexedEmployee.name} ${indexedEmployee.surname}',
              style: Theme.of(context).textTheme.headline6),
          footer: Text(
            indexedEmployee.email,
            overflow: TextOverflow.clip,
          )),
    );
  }
}
