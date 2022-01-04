import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:basic_flutter/presentation/widget/build_name_widget.dart';
import 'package:flutter/material.dart';
import '../../data/employee.dart';
import '../../presentation/screens/employee_preferences.dart';
import '../../presentation/widget/profile_widget.dart';
import '../../presentation/widget/build_contact_widget.dart';
import '../../presentation/screens/edit_profile_page.dart';
import '../../themes.dart';

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
                      sentWidget: const SizedBox(
                        width: 0.0,
                        height: 0.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  BuildNameWidget(employee: employee),
                  const SizedBox(height: 5),
                  BuildContactWidget(employee: employee),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = isDarkMode ? Icons.light_mode : Icons.dark_mode;

  return AppBar(
    backgroundColor: Colors.blue.shade900,
    title: const Text('Employee dialog'),
    centerTitle: true,
    leading: const BackButton(
      color: Colors.white,
    ),
    elevation: 0,
    actions: [
      IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EditProfilePage()));
          }),
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: Icon(icon),
          onPressed: () {
            final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;
            final switcher = ThemeSwitcher.of(context)!;
            switcher.changeTheme(theme: theme);
          },
        ),
      ),
    ],
  );
}
