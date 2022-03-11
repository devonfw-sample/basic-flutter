import 'package:flutter/material.dart';

import '../../data/employee.dart';

class EmployeeGridItem extends StatelessWidget {
  const EmployeeGridItem({Key? key, required this.indexedEmployee})
      : super(key: key);

  final Employee indexedEmployee;
  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Text('${indexedEmployee.name} ${indexedEmployee.surename}',
            style: Theme.of(context).textTheme.headline6),
        footer: Text(
          indexedEmployee.email,
          overflow: TextOverflow.clip,
        ));
  }
}
