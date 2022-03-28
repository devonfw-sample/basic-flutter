import 'package:flutter/material.dart';
import '../../data/employee.dart';

class BuildContactWidget extends StatelessWidget {
  const BuildContactWidget({Key? key, required this.employee})
      : super(key: key);
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: ListView(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text("Contact",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(employee.email.toString()),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(employee.employeeId.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
