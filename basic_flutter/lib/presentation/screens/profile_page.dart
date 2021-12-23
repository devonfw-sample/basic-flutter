import 'package:basic_flutter/presentation/widget/build_name_widget.dart';
import 'package:flutter/material.dart';
import '../../data/employee.dart';
import '../../presentation/screens/employee_preferences.dart';
import '../../presentation/widget/appbar_widget.dart';
import '../../presentation/widget/profile_widget.dart';
import '../../presentation/widget/build_contact_widget.dart';

class ProfilePage extends StatelessWidget {
  final Employee employee;
  const ProfilePage({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final employee = EmployeePreferences.getEmployee();

    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: ProfileWidget(
                        imagePath: employee.imagePath,
                        onClicked: () {},
                        sentWidget: Container(
                          width: 0.0,
                          height: 0.0,
                        ),
                      )),
                  const SizedBox(height: 24),
                  BuildNameWidget(employee: employee),
                  const SizedBox(height: 5),
                  BuildContactWidget(employee: employee),
                ],
              )),
        ],
      )),
    );
  }
}
