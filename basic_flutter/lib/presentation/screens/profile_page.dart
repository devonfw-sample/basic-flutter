import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../../data/routes.dart';
import '../../themes.dart';
import '../widgets/build_name_widget.dart';
import 'package:flutter/material.dart';
import '../../data/employee.dart';
import '../widgets/profile_widget.dart';
import '../widgets/build_contact_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Employee employeeInstance =
        ModalRoute.of(context)!.settings.arguments as Employee;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final icon = isDarkMode ? Icons.light_mode : Icons.dark_mode;

    return Scaffold(
      appBar: AppBar(
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
                Navigator.of(context).pushNamed(Routes.editProfilePageRouteName,
                    arguments: employeeInstance);
              }),
          ThemeSwitcher(
            builder: (context) => IconButton(
              icon: Icon(icon),
              onPressed: () {
                final theme =
                    isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;
                final switcher = ThemeSwitcher.of(context)!;
                switcher.changeTheme(theme: theme);
              },
            ),
          ),
        ],
      ),
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
                      onClicked: () {},
                      sentWidget: const SizedBox(
                        width: 0.0,
                        height: 0.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  BuildNameWidget(employee: employeeInstance),
                  const SizedBox(height: 5),
                  BuildContactWidget(employee: employeeInstance),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
