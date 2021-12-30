import 'package:basic_flutter/presentation/screens/new_employee_preferences.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import '../themes.dart';
import 'presentation/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Employee Profile';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const employee = NewEmployeePreferences.newEmployee;

    return ThemeProvider(
        initTheme:
            employee.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
        child: Builder(
            builder: (context) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeProvider.of(context),
                  title: title,
                  home: Home(),
                )));
  }
}
