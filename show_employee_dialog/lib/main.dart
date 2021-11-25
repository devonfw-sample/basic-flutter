import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:employee/Employee profile/employee_preferences.dart';
import 'package:employee/themes.dart';
import 'package:flutter/material.dart';
import 'Employee profile/profile_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Employee Profile';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const employee = EmployeePreferences.myEmployee;

    return ThemeProvider(
        initTheme:
            employee.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
        child: Builder(
            builder: (context) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeProvider.of(context),
                  title: title,
                  home: const ProfilePage(
                      employee: EmployeePreferences.myEmployee),
                )));
  }
}
