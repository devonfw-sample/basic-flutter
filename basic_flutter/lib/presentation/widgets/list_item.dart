import 'package:flutter/material.dart';

import '/repository/data_provider.dart';
import '../../data/employee.dart';

class ListItem extends StatelessWidget {
  static const String employeesInsertEndpoint =
      'https://app.swaggerhub.com/apis/flutterteam2/basic-flutter/1.0.0#/employeemanagement/v1/employee';
  const ListItem(
      {Key? key,
      required this.index,
      required this.switchToEmployeePage,
      required this.dataProvider})
      : super(key: key);

  final int index;
  final Function switchToEmployeePage;
  final DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    // final currentEmployee = Employee.fromJson(dataProvider.response);
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          switchToEmployeePage(context);
        },
        child: Card(
          elevation: 10,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("firstName LastName",
                  style: Theme.of(context).textTheme.headline6),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "email",
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
