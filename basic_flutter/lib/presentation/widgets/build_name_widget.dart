import 'package:flutter/material.dart';
import '../../data/employee.dart';

class BuildNameWidget extends StatelessWidget {
  const BuildNameWidget({Key? key, required this.employee}) : super(key: key);
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height *
            0.18, // space between details and contact
        child: Column(
          children: [
            Text(
              employee.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              employee.surname,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 5),
          ],
        ));
  }
}
